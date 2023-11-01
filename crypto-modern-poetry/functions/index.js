const { onSchedule } = require('firebase-functions/v2/scheduler');
const logger = require('firebase-functions/logger');
const { findMnemonic, getRecentMnemonic, writePoem } = require('./flow');
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
        throw e;
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
        const words = mnemonic.words.join(' ');
        logger.info('words:', words);
        const poem = await genPoem({ words });
        logger.info('poem:', poem);

        const blockHeight = mnemonic.blockHeight;
        const svg = genSvg({ poem, words, blockHeight });
        logger.info('svg:', svg);

        const png = await svgToPng({ svg });
        logger.info('png convert done');

        await postTweetWithPng({ png, words });
        logger.info('tweet done');

        await writePoem({ words, poem });
        logger.info('write done');
    } catch (e) {
        logger.error(e);
        throw e;
    }
});

// const { onRequest } = require('firebase-functions/v2/https');
// exports.generateTst = onRequest(async (_req, res) => {
//     try {
//         // const svg = genSvg({
//         //     poem: 'こいぬの勇気はやさしい、\n畏縮し、心を込めた信誓。\n砂糖吹きのきなこの味、挫けぬ。\n\n異人の王子、遠い島、\n贈り物は寝札、忘れ置きし品。\n切なさ埋めて、心凍りてしまう。',
//         //     words: 'こいぬ いひん ゆうき やさしい しまう しんせいじ きなこ こりる おうじ でっぱ いみん ねふだ',
//         //     blockHeight: '12345'
//         // });
        
// //         const words = `たいこ やよい けってい たなばた こえる ひだり てぬき あゆむ こおり さこつ めんきょ ぐたいてき`;
// //         const poem = `太鼓鳴り響き、煌々とやよいの光 
// // 左手に抱く決定と免許、燃えるほど决然と
// // 織姫と彦星、棚橋に手繰る声、共鳴のてぬき、歩む。

// // 固体的な氷の下、鮎が躍る。 
// // さこつな想い、切々と流れる如く。`;

//         const words = `とくべつ ほあん さこく そうだん ぎいん あめりか こもち ねんおし すっかり さとおや うよく へいげん`;
//         const poem = `特別な保安の相談、
// 私の郷里とアメリカの議員が年忘れに。
// すっかり心籠る平原、
// 空を駆ける散大やと偶然。`;

//         const svg = genSvg({ poem, words, blockHeight: '12345' });
//         const png = await svgToPng({ svg });

//         await writePoem({ words, poem });

//         res.status(200).send(png);
//     } catch (e) {
//         logger.error(e);
//         res.status(500).send('Failed');
//     }
// });