# ニーモニックの詩

https://x.com/hashtag/%E3%83%8B%E3%83%BC%E3%83%A2%E3%83%8B%E3%83%83%E3%82%AF%E3%81%AE%E8%A9%A9?src=hashtag_click&f=live

## 作品解説
この作品は、生成的な作品を自律的に作り続けることを目指したものです。Flow ブロックチェーンのブロック ID を 12 単語の日本語ニーモニックに変換し、その単語を使って ChatGPT に短い現代詩を生成してもらいます。生成された詩は SVG 画像として視覚化され、X と Bluesky に投稿されます。また、その詩は Flow ブロックチェーンのスマートコントラクトに記録され、以降のブロック ID に影響を与えます。これらのプロセスはすべて自動化しており、2023年11月1日から毎日1回実行しています。ChatGPT のモデルがアップデートされるたびに、そのモデルに積極的に切り替えています。

私はこの作品が自分のものだとは考えていません。ChatGPT が進化し続ける中、毎日一定のルールで作品を作り続けることで、時代の変遷を反映した一種の記録として機能する可能性があるのではないかと思っています。この活動が価値を持つかはまだわかりません。ただ、生成される詩はなかなか面白いものです。重要なことは、私は最初に自動化のプログラムをつくり自動実行の設定を行なっただけであり、そのあとの10ヶ月近くはほとんど何もしていないということです。

## 作品データ（主要なコード）
### バックエンド
- [functions/index.js](./functions/index.js) : メイン関数
- [functions/flow.js](./functions/flow.js) : Flow とのやり取り
- [functions/openai.js](./functions/openai.js) : OpenAI とのやり取り
- [functions/image.js](./functions/image.js) : SVG 画像生成
- [functions/twitter.js](./functions/twitter.js) : X への投稿
- [functions/bsky.js](./functions/bsky.js) : Bluesky への投稿

### スマートコントラクト
- [contracts/cadence/contracts/MnemonicPoetry.cdc](./contracts/cadence/contracts/MnemonicPoetry.cdc)
- [contracts/cadence/contracts/BIP39WordList.cdc](./contracts/cadence/contracts/BIP39WordList.cdc)
- デプロイ済み: https://www.flowdiver.io/contract/A.1717d6b5ee65530a.MnemonicPoetry?tab=deployments
- トランザクションの例: https://www.flowdiver.io/tx/e49dde9ed55d485be12bec53a6d237918225d0b6a25004019fc6a68ed7b08024?tab=events

### その他
#### Cadence 1.0 Migration 2024/07/24

```sh
sudo sh -ci "$(curl -fsSL https://raw.githubusercontent.com/onflow/flow-cli/master/install.sh)"
flow-c1 version

flow-c1 emulator
flow-c1 deploy

# flow-c1 migrate stage BIP39WordList --network=mainnet
# flow-c1 migrate is-staged BIP39WordList --network=mainnet
# flow-c1 migrate is-validated BIP39WordList --network=mainnet

flow-c1 migrate stage BIP39WordListJa --network=mainnet
flow-c1 migrate is-staged BIP39WordListJa --network=mainnet
flow-c1 migrate is-validated BIP39WordListJa --network=mainnet

flow-c1 migrate stage MnemonicPoetry --network=mainnet
flow-c1 migrate is-staged MnemonicPoetry --network=mainnet
flow-c1 migrate is-validated MnemonicPoetry --network=mainnet
```
