const fs = require('fs');
const path = require('path');

process.env.FONTCONFIG_PATH = process.env.FONTCONFIG_PATH || __dirname;

const { getRecentMnemonic } = require('./flow');
const { genPoem } = require('./openai');
const { genSvg, svgToPng } = require('./image');

(async () => {
    console.log('[1/4] Fetching recent mnemonic from Flow mainnet...');
    const mnemonic = await getRecentMnemonic();
    if (!mnemonic) {
        throw new Error('No mnemonic found on chain.');
    }
    const words = mnemonic.words.join(' ');
    console.log('  block height:', mnemonic.blockHeight);
    console.log('  words       :', words);

    console.log('\n[2/4] Generating poem via OpenAI...');
    const poem = await genPoem({ words });
    console.log('\n--- Poem ---');
    console.log(poem);
    console.log('------------\n');

    console.log('[3/4] Rendering SVG...');
    const svg = genSvg({ poem, words, blockHeight: mnemonic.blockHeight });

    console.log('[4/4] Converting to PNG...');
    const png = await svgToPng({ svg });
    const outPath = path.resolve(__dirname, 'preview.png');
    fs.writeFileSync(outPath, png);
    console.log('  saved:', outPath);
    console.log('\nDone. No on-chain / X / Bluesky writes performed.');
})().catch((e) => {
    console.error('Error:', e);
    process.exit(1);
});
