# Digital Native Art

Code is executable literature. Blockchain creates a completely new digital world where code exists and continues to run. We can create digital-native entities that exist only in this environment. The “Digital Native Art Series” is a group of smart contract works created in a resource-oriented manner to create such an entity.

コードは実行可能な文学です。ブロックチェーンは、コードが存在し実行され続ける全く新しいデジタル世界をつくります。私たちはこの環境にのみ存在するデジタルネイティブなモノをつくることができます。「Digital Native Art Series」は、そのような存在を生み出すためにリソース指向でつくられたスマートコントラクトの作品群です。

Anyone can interact with this code to create or destroy objects named `Art` in the digital world.

誰もが、このコードとインタラクションして、デジタル世界に「アート」と名付けられたモノを創造でき、また、破壊できます。

https://www.flowdiver.io/contract/A.a19cf4dba5941530.DigitalNativeArt?tab=deployments


## Cadence 1.0 Migration 2024/07/24

```sh
sudo sh -ci "$(curl -fsSL https://raw.githubusercontent.com/onflow/flow-cli/master/install.sh)"
flow-c1 version

flow-c1 emulator
flow-c1 deploy

flow-c1 migrate stage DigitalNativeArt --network=mainnet
flow-c1 migrate is-staged DigitalNativeArt --network=mainnet
flow-c1 migrate is-validated DigitalNativeArt --network=mainnet

flow-c1 migrate stage Atelier --network=mainnet
flow-c1 migrate is-staged Atelier --network=mainnet
flow-c1 migrate is-validated Atelier --network=mainnet
```
