# functions

ニーモニックの詩のバックエンド。Firebase Cloud Functions v2（Node.js 22）で稼働。

## 構成
- `index.js` : スケジュール関数のエントリポイント
  - `findMnemonic` : 毎日 00:00 JST 実行
  - `generatePoem` : 毎日 07:00 JST 実行
- `preview.js` : 本番に書き込まず、生成 PNG のみローカルに出力する確認スクリプト
- `fonts/ipaexm.ttf` + `fonts.conf` : SVG → PNG 変換時に使う IPAex 明朝フォント

## セットアップ
```sh
cd functions
npm install
```

Flow / OpenAI / X / Bluesky のシークレットは `functions/.env.crypto-modern-poetry` に置く（git 管理外）。

## ローカルプレビュー
オンチェーン書き込み・SNS 投稿を行わずに、最新のニーモニックから詩と画像だけを生成して `preview.png` に保存します。

```sh
cd functions
node preview.js
```

## デプロイ
```sh
cd crypto-modern-poetry   # firebase.json があるディレクトリ
npx -y firebase-tools deploy --only functions
```

初回は `npx firebase-tools login` で認証が必要。

## フォントについて
SVG を PNG 化する `sharp` は内部で librsvg → fontconfig を利用しており、`fonts.conf` の読み込みには環境変数 `FONTCONFIG_PATH` が必須です。

- `index.js` と `preview.js` の冒頭で `process.env.FONTCONFIG_PATH = __dirname` を設定しています。`sharp` を require する**前**に設定する必要があるため、ファイル先頭で行うこと。
- `fonts.conf` には `./fonts` と `/workspace/fonts`（Cloud Functions v2 = Cloud Run のデプロイ先）の両方を `<dir>` 指定しています。
- フォントを差し替えるときは `fonts/` にファイルを置き、`image.js` の `font-family` を更新してください。
