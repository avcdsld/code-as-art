const phrase = "天地玄黃宇宙洪荒";
const utf8Bytes = [];

for (let i = 0; i < phrase.length; i++) {
    const char = phrase.charAt(i);
    const encodedChar = encodeURIComponent(char);
    encodedChar.split('%').slice(1).forEach(hex => {
        utf8Bytes.push('\\x' + hex);
    });
}

console.log(utf8Bytes.join(''));
