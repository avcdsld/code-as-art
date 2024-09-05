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
    const callback = () => {};
    await sendTx(txCode, args, callback);
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
    const callback = () => {};
    await sendTx(txCode, args, callback);
};

async function runScript(scriptCode, args) {
    try {
        fcl.config({
            'accessNode.api': network === 'mainnet' ? 'https://rest-mainnet.onflow.org' : 'https://rest-testnet.onflow.org',
            'flow.network': network || 'testnet',
        });
        return await fcl.query({
            cadence: scriptCode,
            args,
        });
    } catch (e) {
        console.log(e);
    }
}

async function sendTx(txCode, args, callback) {
    try {
        fcl.config({
            'accessNode.api': network === 'mainnet' ? 'https://rest-mainnet.onflow.org' : 'https://rest-testnet.onflow.org',
            'flow.network': network || 'testnet',
        });
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
        logger.info(tx.transactionId);
        const unsub = fcl.tx(tx).subscribe((currentTx) => {
            try {
                if (fcl.tx.isSealed(currentTx)) {
                    console.log('Transaction is Sealed', currentTx.events.length > 0 ? currentTx.events[0].data : currentTx);
                    callback();
                    unsub();
                }
            } catch (e) {
                logger.error(e);
            }
        });
    } catch (e) {
        console.log(e);
    }
}
