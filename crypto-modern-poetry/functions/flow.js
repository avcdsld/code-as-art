const fcl = require('@onflow/fcl');
const { sign } = require('./signer');
const logger = require('firebase-functions/logger');

const network = 'mainnet';
// const network = 'testnet';

const txInfo = {
    mnemonicPoetryAddress: network === 'mainnet' ? '0x1717d6b5ee65530a' : 'TODO',
    senderAddress: network === 'mainnet' ? '0x1717d6b5ee65530a' : '0x374e363b89924b5e',
    senderKeyId: 1,
};

exports.findMnemonic = async () => {
    try {
        const txCode = `\
import MnemonicPoetry from ${txInfo.mnemonicPoetryAddress}

transaction {
    prepare(signer: AuthAccount) {
        if signer.borrow<&MnemonicPoetry.PoetryCollection>(from: /storage/MnemonicPoetryCollection) == nil {
            signer.save(<- MnemonicPoetry.createEmptyPoetryCollection(), to:  /storage/MnemonicPoetryCollection)

            signer.link<&MnemonicPoetry.PoetryCollection{MnemonicPoetry.PoetryCollectionPublic}>(/public/MnemonicPoetryCollection, target: /storage/MnemonicPoetryCollection)
            // let cap = signer.capabilities.storage.issue<&MnemonicPoetry.PoetryCollection{MnemonicPoetry.PoetryCollectionPublic}>(/storage/MnemonicPoetryCollection)
            // signer.capabilities.publish(cap, at: /public/MnemonicPoetryCollection)
        }
        let poetryCollectionRef = signer.borrow<&MnemonicPoetry.PoetryCollection>(from: /storage/MnemonicPoetryCollection)!
        poetryCollectionRef.findMnemonic()
    }
}`;
        const callback = () => {}
        await sendTx(txCode, callback);
    } catch (e) {
        console.log(e);
    }
};

exports.getRecentMnemonic = async () => {
    try {
        const scriptCode = `\
import MnemonicPoetry from ${txInfo.mnemonicPoetryAddress}

pub fun main(addr: Address): MnemonicPoetry.Mnemonic? {
    // let collectionRef = getAccount(addr).capabilities
    //                     .borrow<&MnemonicPoetry.PoetryCollection{MnemonicPoetry.PoetryCollectionPublic}>
    //                     (/public/MnemonicPoetryCollection) ?? panic("Not Found")
    let collectionRef = getAccount(addr).getCapability<&MnemonicPoetry.PoetryCollection{MnemonicPoetry.PoetryCollectionPublic}>
                        (/public/MnemonicPoetryCollection)
                        .borrow() ?? panic("Not Found")
    let poems = collectionRef.mnemonics
    if poems.length == 0 {
        return nil
    }
    return poems[poems.length - 1]
}`;
        return await runScript(scriptCode, []);
    } catch (e) {
        console.log(e);
    }
};

async function runScript(scriptCode, args) {
    try {
        fcl.config({
            'accessNode.api': network === 'mainnet' ? 'https://rest-mainnet.onflow.org' : 'https://rest-testnet.onflow.org',
            'flow.network': network || 'testnet',
        });
        return await fcl.query({
            cadence: `\
import MnemonicPoetry from ${txInfo.mnemonicPoetryAddress}

pub fun main(): MnemonicPoetry.Mnemonic? {
    let addr: Address = ${txInfo.mnemonicPoetryAddress}
    // let collectionRef = getAccount(addr).capabilities
    //                     .borrow<&MnemonicPoetry.PoetryCollection{MnemonicPoetry.PoetryCollectionPublic}>
    //                     (/public/MnemonicPoetryCollection) ?? panic("Not Found")
    let collectionRef = getAccount(addr).getCapability<&MnemonicPoetry.PoetryCollection{MnemonicPoetry.PoetryCollectionPublic}>
                        (/public/MnemonicPoetryCollection)
                        .borrow() ?? panic("Not Found")
    let poems = collectionRef.mnemonics
    if poems.length == 0 {
        return nil
    }
    return poems[poems.length - 1]
}`,
            args,
        });
    } catch (e) {
        console.log(e);
    }
}

async function sendTx(txCode, callback) {
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
            fcl.args([]),
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
