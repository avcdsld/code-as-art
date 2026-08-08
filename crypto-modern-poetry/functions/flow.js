const fcl = require('@onflow/fcl');
const { sign } = require('./signer');
const logger = require('firebase-functions/logger');

const network = 'mainnet';
// const network = 'testnet';

const txInfo = {
    mnemonicPoetryAddress: network === 'mainnet' ? '0x1717d6b5ee65530a' : 'TODO',
    senderAddress: network === 'mainnet' ? '0x1717d6b5ee65530a' : '0x374e363b89924b5e',
    senderKeyId: network === 'mainnet' ? 2 : 1,
};

exports.findMnemonic = async () => {
    const txCode = `\
import MnemonicPoetry from ${txInfo.mnemonicPoetryAddress}

transaction {
    prepare(signer: auth(BorrowValue, SaveValue, IssueStorageCapabilityController, PublishCapability) &Account) {
        if signer.storage.borrow<&MnemonicPoetry.PoetryCollection>(from: /storage/MnemonicPoetryCollection) == nil {
            signer.storage.save(<- MnemonicPoetry.createEmptyPoetryCollection(), to:  /storage/MnemonicPoetryCollection)
            let cap = signer.capabilities.storage.issue<&MnemonicPoetry.PoetryCollection>(/storage/MnemonicPoetryCollection)
            signer.capabilities.publish(cap, at: /public/MnemonicPoetryCollection)
        }
        let poetryCollectionRef = signer.storage.borrow<&MnemonicPoetry.PoetryCollection>(from: /storage/MnemonicPoetryCollection)!
        poetryCollectionRef.findMnemonic()
    }
}`;
    const args = [];
    await sendTx(txCode, args);
};

exports.getRecentMnemonic = async () => {
    const scriptCode = `\
import MnemonicPoetry from ${txInfo.mnemonicPoetryAddress}

access(all) fun main(): MnemonicPoetry.Mnemonic? {
    let addr: Address = ${txInfo.mnemonicPoetryAddress}
    let collectionRef = getAccount(addr)
                        .capabilities.get<&MnemonicPoetry.PoetryCollection>(/public/MnemonicPoetryCollection)
                        .borrow() ?? panic("Not Found")
    let mnemonics = collectionRef.mnemonics
    if mnemonics.length == 0 {
        return nil
    }
    return collectionRef.getMnemonic(index: mnemonics.length - 1)
}`;
    const args = [];
    return await runScript(scriptCode, args);
};

exports.writePoem = async ({ words, poem }) => {
    const txCode = `\
import MnemonicPoetry from ${txInfo.mnemonicPoetryAddress}

transaction(words: String, poem: String) {
    prepare(signer: auth(SaveValue, BorrowValue, StorageCapabilities, PublishCapability) &Account) {
        if signer.storage.borrow<&MnemonicPoetry.PoetryCollection>(from: /storage/MnemonicPoetryCollection) == nil {
            signer.storage.save(<- MnemonicPoetry.createEmptyPoetryCollection(), to:  /storage/MnemonicPoetryCollection)
            let cap = signer.capabilities.storage.issue<&MnemonicPoetry.PoetryCollection>(/storage/MnemonicPoetryCollection)
            signer.capabilities.publish(cap, at: /public/MnemonicPoetryCollection)
        }
        let collectionRef = signer.storage.borrow<&MnemonicPoetry.PoetryCollection>(from: /storage/MnemonicPoetryCollection)!
        let mnemonics = collectionRef.mnemonics
        if mnemonics.length == 0 {
            panic("Not found")
        }

        var i = mnemonics.length - 1
        while i >= 0 {
            let mnemonic = collectionRef.getMnemonic(index: i)

            var w = ""
            var j = 0
            while j < mnemonic.words.length {
                if j > 0 {
                    w = w.concat(" ")
                }
                w = w.concat(mnemonic.words[j])
                j = j + 1
            }
            if w == words {
                collectionRef.writePoem(mnemonic: mnemonic, poem: poem)
                return
            }
            i = i - 1
        }
        panic("Not found mnemonic")
    }
}`;
    const args = [
        fcl.arg(words, fcl.t.String),
        fcl.arg(poem, fcl.t.String),
    ];
    await sendTx(txCode, args);
};

function configureFcl() {
    fcl.config({
        'accessNode.api': network === 'mainnet' ? 'https://rest-mainnet.onflow.org' : 'https://rest-testnet.onflow.org',
        'flow.network': network || 'testnet',
    });
}

async function runScript(scriptCode, args) {
    // Note: don't swallow errors here. A silent failure previously caused the
    // caller to reuse stale on-chain data. Let the error propagate so the
    // scheduled function fails loudly and shows up in the logs.
    configureFcl();
    return await fcl.query({
        cadence: scriptCode,
        args,
    });
}

async function sendTx(txCode, args) {
    configureFcl();
    const authz = async (account) => {
        const addr = txInfo.senderAddress;
        const keyId = txInfo.senderKeyId;
        return {
            ...account,
            tempId: `${addr}-${keyId}`,
            addr: fcl.sansPrefix(addr),
            // sequenceNum: 1,
            keyId: Number(keyId),
            signingFunction: async (signable) => {
                return {
                    addr: fcl.withPrefix(addr),
                    keyId: Number(keyId),
                    signature: sign(signable.message)
                }
            }
        }
    };
    const tx = await fcl.send([
        fcl.transaction(txCode),
        fcl.args(args),
        fcl.payer(authz),
        fcl.proposer(authz),
        fcl.authorizations([authz]),
        fcl.limit(9999)
    ]);
    const txId = tx.transactionId;
    logger.info('submitted tx', txId);

    // Wait until the transaction is sealed and, crucially, verify it did not
    // revert. A sealed transaction can still have failed at execution time
    // (e.g. Error Code 1103 "storage limit check failed" when the account is
    // out of FLOW). Poll the status instead of using a WebSocket subscription,
    // which was unreliable in the Cloud Functions runtime.
    const sealed = await waitForSeal(txId);
    if (sealed.statusCode !== 0) {
        throw new Error(`Transaction ${txId} reverted: ${sealed.errorMessage || 'unknown error'}`);
    }
    logger.info('tx sealed', txId);
    return sealed;
}

async function waitForSeal(txId, { timeoutMs = 90000, intervalMs = 3000 } = {}) {
    const deadline = Date.now() + timeoutMs;
    // Flow tx status: 4 = Sealed, 5 = Expired
    while (true) {
        const status = await fcl.decode(await fcl.send([fcl.getTransactionStatus(txId)]));
        if (status.status >= 4) {
            return status;
        }
        if (Date.now() > deadline) {
            throw new Error(`Transaction ${txId} not sealed within ${timeoutMs}ms (last status ${status.status})`);
        }
        await new Promise((r) => setTimeout(r, intervalMs));
    }
}
