const sharp = require('sharp');

exports.genSvg = ({ poem, words, blockHeight }) => {
    const colors = [
        '#0D3A58', '#A22041', '#3F714B', '#8B4513', '#001F3F',
        '#BEB16B', '#8D9139', '#001B30', '#4B0082', '#4B4E2A'
    ];
    const randomColor = colors[Math.floor(Math.random() * colors.length)];

    const getLength = (str) => {
        let length = 0;
        for (const char of str) {
            length += (char.charCodeAt(0) > 127) ? 2 : 1;
        }
        return length;
    };

    const breakTextIntoLines = (str, maxLength) => {
        let result = [];
        while (getLength(str) > maxLength) {
            let len = maxLength;
            while (getLength(str.substr(0, len)) > maxLength) {
                len--;
            }
            result.push(str.substr(0, len));
            str = str.substr(len);
        }
        if (str) result.push(str);
        return result;
    };

    const poemLines = poem.trim().split('\n').flatMap(line => breakTextIntoLines(line, 42)); // 21全角文字分

    const formattedPoem = poemLines.map((line, idx) => {
        const yPosition = 70 + (idx * 26);
        return `<text x="30" y="${yPosition}" font-family="'IPAexMincho,'IPAMincho'" fill="white" font-size="16">${line}</text>`;
    }).join('');

    const wordsLines = breakTextIntoLines(words, 56); // 28全角文字分
    const formattedWords = wordsLines.map((line, idx) => {
        const yPosition = 330 + (idx * 16);
        return `<text x="30" y="${yPosition}" font-family="'IPAexMincho,'IPAMincho'" fill="white" font-size="12">${line}</text>`;
    }).join('');

    const svgString = `
<svg width="800" height="800" viewBox="0 0 400 400" xmlns="http://www.w3.org/2000/svg">
    <rect width="400" height="400" fill="${randomColor}" />
    ${formattedPoem}
    <text x="30" y="310" font-family="'IPAexMincho,'IPAMincho'" fill="white" font-size="14">#${blockHeight}</text>
    ${formattedWords}
</svg>`;
    
    return svgString;
};

exports.svgToPng = async ({ svg }) => {
    const buffer = Buffer.from(svg);
    return await sharp(buffer).png().toBuffer();
};
