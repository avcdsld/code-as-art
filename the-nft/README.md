# The NFT ― What makes an NFT an NFT?

“The NFT” is a work consisting of two smart contracts that question the nature of NFT. One is an NFT contract using Cadence, a resource-oriented programming language, and the other is an NFT contract using Solidity, the most popular smart contract language today.

「The NFT」は、NFT の本質を問う 2 つのスマートコントラクトから成る作品です。ひとつは、リソース指向のプログラミング言語である Cadence を使った NFT コントラクト、もうひとつは、現在最も普及しているスマートコントラクト言語である Solidity を使った NFT コントラクトです。


## What Makes an NFT an NFT

The most important metadata returned by this NFT is the “ID“. It is simply a number that is sequentially numbered within this contract; an NFT can be associated with a variety of information, including images, but that association cannot be proven to be unique. Essentially, the only thing that makes an NFT an NFT may be the numbers generated within the smart contract that indicate its identity.


## NFT を NFT たらしめるもの

この NFT が返す最も重要なメタデータは「ID」です。それは単純に、このコントラクトの中で順番に採番された数値です。NFT には画像など様々な情報を紐づけることができますが、その紐付けが一意であることは証明できません。本質的にその NFT を NFT たらしめるものは、そのスマートコントラクトの中で生成された、アイデンティティを示す数字だけである可能性があります。


https://www.flowdiver.io/contract/A.fe437b573d368d6a.TheNFT?tab=deployments

---

## Cadence 1.0 Migration 2024/07/27

```sh
sudo sh -ci "$(curl -fsSL https://raw.githubusercontent.com/onflow/flow-cli/master/install.sh)"
flow-c1 version

flow-c1 emulator
flow-c1 deploy

flow-c1 migrate stage TheNFT --network=mainnet
flow-c1 migrate is-staged TheNFT --network=mainnet
flow-c1 migrate is-validated TheNFT --network=mainnet
```
