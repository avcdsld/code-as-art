# Self-Replication

“Self-Replication” is a smart contract that can replicate itself. It is deployed on the Flow blockchain using the Cadence programming language, which allows for intuitive code expression.

「Self-Replication（自己複製）」は、自分自身を複製することができるスマートコントラクトです。この作品は、直感的なコードの表現が可能な Cadence プログラミング言語を使って、Flow ブロックチェーン上にデプロイされています。


## Ideal code writing/execution environment

Smart contracts executed on the blockchain are a code execution environment with common state throughout the world, where who created the code and when it was created and who executed what remains forever. This is an ideal environment for writing and executing artistic code. I used this environment to explore ways to create code that changes as it receives feedback. This work is the first step in that direction, creating a minimal code that can replicate itself.

## 理想的なコードの記述/実行環境

ブロックチェーン上で実行されるスマートコントラクトは、いつ誰が作り、誰が何を実行したかがずっと残り続ける、全世界で共通のステートを持つコード実行環境です。これは、アートしてのコードを記述・実行する環境として理想的です。私はこの環境を使って、フィードバックを受けながら変化していくコードをつくる方法を模索しました。この作品は、そのための第一歩として、自らを複製できるミニマムのコードを作成したものです。

## Accounts as mothers for nurturing code

Flow provides a storage area for each account where smart contracts can be deployed. In the minimal implementation, I have created one function that takes an account as a function argument and deploys a new contract to that account in code. The code of the deployed contract internally references the code of the executing contract itself. This looks as if it is giving a new life to the mother.

## コードを育む母体としてのアカウント

Flow では、アカウントごとにスマートコントラクトをデプロイできるストレージ領域が用意されています。今回作成したミニマムの実装では、アカウントを関数の引数に取り、そのアカウントに対してコードの中で新しくコントラクトをデプロイする関数をひとつ作りました。デプロイするコントラクトのコードは、実行しているコントラクト自らのコードを内部的に参照します。この様子は、あたかも母体に新しい命を授けているかのようにみえます。


https://www.flowdiver.io/contract/A.fe437b573d368d6a.SelfReplication?tab=deployments

---

## Cadence 1.0 Migration 2024/07/28

```sh
sudo sh -ci "$(curl -fsSL https://raw.githubusercontent.com/onflow/flow-cli/master/install.sh)"
flow-c1 version

flow-c1 emulator
flow-c1 deploy

flow-c1 migrate stage SelfReplication --network=mainnet
flow-c1 migrate is-staged SelfReplication --network=mainnet
flow-c1 migrate is-validated SelfReplication --network=mainnet
```
