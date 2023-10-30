const { onSchedule } = require('firebase-functions/v2/scheduler');
const logger = require('firebase-functions/logger');
const { findMnemonic, getRecentMnemonic } = require('./flow');
const { genPoem } = require('./openai');
const { genSvg, svgToPng } = require('./image');
const { postTweetWithPng } = require('./twitter');

exports.findMnemonic = onSchedule({
    schedule: 'every day 00:00',
    timeZone: 'Asia/Tokyo',
    timeoutSeconds: 120,
}, async (event) => {
    logger.info('findMnemonic:');
    try {
        await findMnemonic();
    } catch (e) {
        logger.error(e);
    }
});

exports.generatePoem = onSchedule({
    schedule: 'every day 07:00',
    timeZone: 'Asia/Tokyo',
    timeoutSeconds: 300,
}, async (event) => {
    logger.info('generatePoem:');
    try {
        const mnemonic = await getRecentMnemonic();
        logger.info('recent mnemonic:', mnemonic);

        const words = mnemonic.words.join(' ');
        const poem = await genPoem({ words });
        logger.info('poem:', poem);

        const blockHeight = mnemonic.blockHeight;
        const svg = genSvg({ poem, words, blockHeight });
        logger.info('svg:', svg);

        const png = await svgToPng({ svg });
        logger.info('png convert done');

        await postTweetWithPng({ png, words });
        logger.info('tweet done');
    } catch (e) {
        logger.error(e);
    }
});

// const { onRequest } = require('firebase-functions/v2/https');
// exports.generateTst = onRequest(async (_req, res) => {
//     try {
//         const svg = genSvg({
//             poem: 'こいぬの勇気はやさしい、\n畏縮し、心を込めた信誓。\n砂糖吹きのきなこの味、挫けぬ。\n\n異人の王子、遠い島、\n贈り物は寝札、忘れ置きし品。\n切なさ埋めて、心凍りてしまう。',
//             words: 'こいぬ いひん ゆうき やさしい しまう しんせいじ きなこ こりる おうじ でっぱ いみん ねふだ',
//             blockHeight: '12345'
//         });
//         const png = await svgToPng({ svg });
//         res.status(200).send(png);
//     } catch (e) {
//         logger.error(e);
//         res.status(500).send('Failed');
//     }
// });