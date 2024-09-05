const { onSchedule } = require('firebase-functions/v2/scheduler');
// const { onRequest } = require("firebase-functions/v2/https");
const logger = require('firebase-functions/logger');
const fcl = require('@onflow/fcl');
const { sign } = require('./signer');

const network = 'mainnet';
// const network = 'testnet';

const txInfo = {
    concreteBlockPoetryAddress: network === 'mainnet' ? '0x23b08a725bc2533d' : '0x374e363b89924b5e',
    undefinedCodeAddress: network === 'mainnet' ? '0x23b08a725bc2533d' : 'TODO',
    senderAddress: network === 'mainnet' ? '0x2ff554854640b4f5' : '0x374e363b89924b5e',
    senderKeyId: 1,
};

exports.writePoem = onSchedule({
    schedule: 'every day 04:00',
    timeZone: 'Asia/Tokyo',
    timeoutSeconds: 120,
}, async (event) => {
    logger.info('write poem:');
    await sendWritePoemTx();
});

exports.findCode = onSchedule({
    schedule: 'every day 05:00',
    timeZone: 'Asia/Tokyo',
    timeoutSeconds: 120,
}, async (event) => {
    logger.info('find code:');
    await sendFindCodeTx();
});

// exports.runWritePoem = onRequest(async (_req, res) => {
//     logger.info('write poem:');
//     await sendWritePoemTx();
//     res.send("runWritePoem executed");
// });

// exports.runFindCode = onRequest(async (_req, res) => {
//     logger.info('find code:');
//     await sendFindCodeTx();
//     res.send("runFindCode executed");
// });

async function sendWritePoemTx() {
    try {
        const txCode = `\
import ConcreteBlockPoetry from ${txInfo.concreteBlockPoetryAddress}
import ConcreteBlockPoetryBIP39 from ${txInfo.concreteBlockPoetryAddress}

transaction {
    prepare(signer: auth(BorrowValue, IssueStorageCapabilityController, PublishCapability, SaveValue, UnpublishCapability) &Account) {
        if signer.storage.borrow<&ConcreteBlockPoetry.PoetryCollection>(from: /storage/PoetryCollectionVol1) == nil {
            signer.storage.save(<- ConcreteBlockPoetry.createEmptyPoetryCollection(), to:  /storage/PoetryCollectionVol1)
            let cap = signer.capabilities.storage.issue<&ConcreteBlockPoetry.PoetryCollection>(/storage/PoetryCollectionVol1)
            signer.capabilities.publish(cap, at: /public/PoetryCollectionVol1)
        }
        let poetryCollectionRef = signer.storage.borrow<auth(ConcreteBlockPoetry.WritePoem) &ConcreteBlockPoetry.PoetryCollection>(from: /storage/PoetryCollectionVol1)!
        poetryCollectionRef.writePoem(poetryLogic: ConcreteBlockPoetry.PoetryLogic())

        if signer.storage.borrow<&ConcreteBlockPoetryBIP39.PoetryCollection>(from: /storage/PoetryCollectionBIP39Vol1) == nil {
            signer.storage.save(<- ConcreteBlockPoetryBIP39.createEmptyPoetryCollection(), to:  /storage/PoetryCollectionBIP39Vol1)
            let cap = signer.capabilities.storage.issue<&ConcreteBlockPoetryBIP39.PoetryCollection>(/storage/PoetryCollectionBIP39Vol1)
            signer.capabilities.publish(cap, at: /public/PoetryCollectionBIP39Vol1)
        }
        let poetryCollectionBIP39Ref = signer.storage.borrow<auth(ConcreteBlockPoetryBIP39.WritePoem) &ConcreteBlockPoetryBIP39.PoetryCollection>(from: /storage/PoetryCollectionBIP39Vol1)!
        poetryCollectionBIP39Ref.writePoems(poetryLogic: ConcreteBlockPoetryBIP39.PoetryLogic())
    }
}`;
        const callback = () => {
            logger.info('OK');
        }
        await sendTx(txCode, callback);
    } catch (e) {
        logger.error(e);
    }
}

async function sendFindCodeTx() {
    try {
        const txCode = `\
import UndefinedCode from ${txInfo.undefinedCodeAddress}

transaction {
    prepare(signer: auth(SaveValue, LoadValue, BorrowValue) &Account) {
        let code <- UndefinedCode.find()
        let storagePath = StoragePath(identifier: "UndefinedCode".concat(code.point.toString()))!
        if signer.storage.borrow<&UndefinedCode.Code>(from: storagePath) == nil {
            signer.storage.save(<- code, to: storagePath)
        } else {
            let specialStoragePath = StoragePath(identifier: "UndefinedCode".concat(code.point.toString()).concat(getCurrentBlock().timestamp.toString()))!
            signer.storage.save(<- code, to: specialStoragePath)
        }
    }
}`;
        const callback = () => {
            logger.info('OK');
        }
        await sendTx(txCode, callback);
    } catch (e) {
        logger.error(e);
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
                // sequenceNum: 732,
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
        logger.error(e);
    }
};
