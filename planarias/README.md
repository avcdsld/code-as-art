# Planarias

I have released 100 planarias into the digital world. They have genes and reproduce sexually and asexually to increase their offspring. How far will they be able to survive and increase their diversity without going extinct?

100匹のプラナリアをデジタル世界に放ちました。彼らは遺伝子を持ち、有性生殖と無性生殖で子孫を増やします。果たして彼らは絶滅せずに生き残り、どこまで多様性を高めることができるでしょうか。

https://www.flowdiver.io/contract/A.d370ae493b8acc86.Planarias?tab=deployments


## Cadence 1.0 Migration 2024/07/24

```sh
sudo sh -ci "$(curl -fsSL https://raw.githubusercontent.com/onflow/flow-cli/master/install.sh)"
flow-c1 version

flow-c1 emulator
flow-c1 deploy

flow-c1 migrate stage Planarias --network=mainnet
flow-c1 migrate is-staged Planarias --network=mainnet
flow-c1 migrate is-validated Planarias --network=mainnet
```
