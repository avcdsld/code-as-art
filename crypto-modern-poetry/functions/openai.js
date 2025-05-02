const { defineString } = require('firebase-functions/params');
const OpenAI = require('openai');
const logger = require('firebase-functions/logger');

const openaiApiKeyConfig = defineString('OPENAI_API_KEY');

exports.genPoem = async ({ words }) => {
    const openai = new OpenAI({
        apiKey: openaiApiKeyConfig.value(),
        maxRetries: 3,
        timeout: 60 * 1000,
    });

    const prompt = `以下の12個の単語を使って、3〜4行の短い現代詩をつくってください。単語は、できるだけ適宜、漢字に変換してください。
    ${words}`;

    const chatCompletion = await openai.chat.completions.create({
        messages: [{ role: 'user', content: prompt }],
        // model: 'gpt-3.5-turbo',
        // model: 'gpt-4', // 2023/10/30 - 2024/05/15
        // model: 'gpt-4o', // 2024/05/16 - 2024/11/20
        // model: 'o1-preview', // 2024/11/21 - 2025/05/02
        model: 'o3', // 2025/05/03 -
    }, {
        timeout: 60 * 1000,
    });
    logger.info(chatCompletion.choices);

    const poem = chatCompletion.choices[0].message.content;
    return poem;
};

