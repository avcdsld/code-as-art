const { SHA3 } = require("sha3");
const { ec } = require("elliptic");
const EC = new ec('secp256k1');

const PRIVATE_KEY = process.env.PRIVATE_KEY;

const hash = (message) => {
    const sha = new SHA3(256);
    sha.update(Buffer.from(message, 'hex'));
    return sha.digest();
}

exports.sign = function (message) {
    const key = EC.keyFromPrivate(Buffer.from(PRIVATE_KEY, 'hex'));
    const sig = key.sign(hash(message)); // hashMsgHex -> hash
    const n = 32;
    const r = sig.r.toArrayLike(Buffer, 'be', n);
    const s = sig.s.toArrayLike(Buffer, 'be', n);
    return Buffer.concat([r, s]).toString('hex');
}
