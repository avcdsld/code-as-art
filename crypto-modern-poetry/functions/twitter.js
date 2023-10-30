const { defineString } = require('firebase-functions/params');
const { TwitterApi } = require('twitter-api-v2');

const twitterApiKeyConfig = defineString('TWITTER_API_KEY');
const twitterApiKeySecretConfig = defineString('TWITTER_API_KEY_SECRET');
const twitterAccessTokenConfig = defineString('TWITTER_ACCESS_TOKEN');
const twitterAccessTokenSecretConfig = defineString('TWITTER_ACCESS_TOKEN_SECRET');

exports.postTweetWithPng = async ({ png, words }) => {
    const client = new TwitterApi({
        appKey: twitterApiKeyConfig.value(),
        appSecret: twitterApiKeySecretConfig.value(),
        accessToken: twitterAccessTokenConfig.value(),
        accessSecret: twitterAccessTokenSecretConfig.value(),
    });
    const mediaId = await client.v1.uploadMedia(png, { mimeType: 'image/png' });
    console.log({mediaId});
    await client.v2.tweet({
        text: `${words}
#ニーモニックの詩`,
        media: { media_ids: [mediaId] }
    });
};
