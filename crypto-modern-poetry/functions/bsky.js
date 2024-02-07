const { defineString } = require('firebase-functions/params');
const { BskyAgent } = require('@atproto/api');

const bskyIdentifier = defineString('BSKY_IDENTIFIER');
const bskyPassword = defineString('BSKY_PASSWORD');

exports.postTweetWithPng = async ({ png, words, poem }) => {
    const agent = new BskyAgent({
        service: 'https://bsky.social'
    });
    await agent.login({
        identifier: bskyIdentifier.value(),
        password: bskyPassword.value()
    });
    const { data } = await agent.uploadBlob(png, { encoding: 'image/png' });
    await agent.post({
        text: `${words}
#ニーモニックの詩`,
        embed: {
            $type: 'app.bsky.embed.images',
            images: [
                // can be an array up to 4 values
                {
                    alt: poem,
                    image: data.blob,
                    aspectRatio: {
                        // a hint to clients
                        width: 800,
                        height: 800
                    }
                },
            ],
        },
        createdAt: new Date().toISOString()
    })
};
