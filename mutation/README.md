# Mutation

“Mutation” is a further development of “Self-Replication”, a smart contract that can randomly change its own code in addition to replicating it.

「Mutation（突然変異）」は、「Self-Replication」をさらに発展させたもので、複製することに加えて自身のコードをランダムに変更することができるスマートコントラクトです。

## Continuous code change history

With blockchain and smart contracts, code can be written and executed in the same place. Traditionally, to achieve this, a separate, dedicated environment had to be built, but smart contracts enable this difficulty to be overcome. This piece provides the simple example. The smart contract has a function called `mutate()` that can be called to make changes to its own code. In this example, the name of the contract `Mutation` is randomly changed to a single letter `X`. For example, `MXtation`. The code that has been modified is then replicated by calling the function `replicate()`. Any history of changes to the code will remain persistent.

## 連続するコード変更の履歴

ブロックチェーンおよびスマートコントラクトを使えば、コードの記述と実行を同じ場所で行うことができます。従来、これを実現するためには、個別に専用の環境を構築しなければなりませんでしたが、スマートコントラクトはその困難を乗り越えることを可能にします。この作品では、そのシンプルな例を示しています。スマートコントラクトには、`mutate()` という関数があり、これを呼び出すと自身のコードに変更が加えられます。この例では、コントラクトの名前 `Mutation` がランダムに一文字だけ `X` という文字に変わります。例えば、`MXtation` のように。その後、`replicate()` という関数を呼び出すことで、変更が加えられたコードが複製されます。コードを変更した履歴は、すべて永続的に残り続けます。


https://www.flowdiver.io/contract/A.fe437b573d368d6a.Mutation?tab=deployments

---

## Cadence 1.0 Migration 2024/07/28

```sh
sudo sh -ci "$(curl -fsSL https://raw.githubusercontent.com/onflow/flow-cli/master/install.sh)"
flow-c1 version

flow-c1 emulator
flow-c1 deploy

flow-c1 migrate stage Mutation --network=mainnet
flow-c1 migrate is-staged Mutation --network=mainnet
flow-c1 migrate is-validated Mutation --network=mainnet

flow-c1 migrate stage MXtation --network=mainnet
flow-c1 migrate is-staged MXtation --network=mainnet
flow-c1 migrate is-validated MXtation --network=mainnet

flow-c1 migrate stage MutaXion --network=mainnet
flow-c1 migrate is-staged MutaXion --network=mainnet
flow-c1 migrate is-validated MutaXion --network=mainnet
```
