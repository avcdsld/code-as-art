const functions = require("firebase-functions");
const fcl = require("@onflow/fcl");
const { sign } = require("./signer");

const network = 'mainnet';
// const network = 'testnet';

const txInfo = {
    concreteBlockPoetryAddress: network === "mainnet" ? "0x23b08a725bc2533d" : "0x374e363b89924b5e",
    undefinedCodeAddress: network === "mainnet" ? "0x23b08a725bc2533d" : "TODO",
    senderAddress: network === "mainnet" ? "0x2ff554854640b4f5" : "0x374e363b89924b5e",
    senderKeyId: 1,
};

exports.writePoem = functions.https.onRequest((_req, res) => {
    functions.logger.info("write poem:");
    sendWritePoemTx(res);
});

exports.findCode = functions.https.onRequest((_req, res) => {
    functions.logger.info("find code:");
    sendFindCodeTx(res);
});

async function sendWritePoemTx(res) {
    try {
        const txCode = `\
import ConcreteBlockPoetry from ${txInfo.concreteBlockPoetryAddress}

transaction {
    prepare(signer: AuthAccount) {
        if signer.borrow<&ConcreteBlockPoetry.PoetryCollection>(from: /storage/PoetryCollectionVol1) == nil {
            signer.save(<- ConcreteBlockPoetry.createEmptyPoetryCollection(), to:  /storage/PoetryCollectionVol1)

            signer.link<&ConcreteBlockPoetry.PoetryCollection{ConcreteBlockPoetry.PoetryCollectionPublic}>(/public/PoetryCollectionVol1, target: /storage/PoetryCollectionVol1)
            // let cap = signer.capabilities.storage.issue<&ConcreteBlockPoetry.PoetryCollection{ConcreteBlockPoetry.PoetryCollectionPublic}>(/storage/PoetryCollectionVol1)
            // signer.capabilities.publish(cap, at: /public/PoetryCollectionVol1)
        }
        let poetryCollectionRef = signer.borrow<&ConcreteBlockPoetry.PoetryCollection>(from: /storage/PoetryCollectionVol1)!
        let poetryLogic = ConcreteBlockPoetry.PoetryLogic()
        poetryCollectionRef.writePoem(poetryLogic: poetryLogic)
    }
}`;
        const callback = () => {
            res.send("OK");
        }
        await sendTx(txCode, callback);
    } catch (e) {
        console.log(e);
    }
}

async function sendFindCodeTx(res) {
    try {
        const txCode = `\
import UndefinedCode from ${txInfo.undefinedCodeAddress}

transaction {
    prepare(signer: AuthAccount) {
        let code <- UndefinedCode.find()
        let storagePath = StoragePath(identifier: "UndefinedCode".concat(code.point.toString()))!
        if signer.borrow<&UndefinedCode.Code>(from: storagePath) == nil {
            signer.save(<- code, to: storagePath)
        } else {
            let specialStoragePath = StoragePath(identifier: "UndefinedCode".concat(code.point.toString()).concat(getCurrentBlock().timestamp.toString()))!
            signer.save(<- code, to: specialStoragePath)
        }
    }
}`;
        const callback = () => {
            res.send("OK");
        }
        await sendTx(txCode, callback);
    } catch (e) {
        console.log(e);
    }
}

async function sendTx(txCode, callback) {
    try {
        fcl.config({
            "accessNode.api": network === "mainnet" ? "https://rest-mainnet.onflow.org" : "https://rest-testnet.onflow.org",
            "flow.network": network || "testnet",
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
        functions.logger.info(tx.transactionId);
        const unsub = fcl.tx(tx).subscribe((currentTx) => {
            try {
                if (fcl.tx.isSealed(currentTx)) {
                    console.log("Transaction is Sealed", currentTx.events.length > 0 ? currentTx.events[0].data : currentTx);
                    callback();
                    unsub();
                }
            } catch (e) {
                functions.logger.error(e);
            }
        });
    } catch (e) {
        console.log(e);
    }
};
