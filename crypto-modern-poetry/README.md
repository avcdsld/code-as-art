# Mnemonic Poetry

https://www.flowdiver.io/contract/A.1717d6b5ee65530a.MnemonicPoetry?tab=deployments


## Cadence 1.0 Migration 2024/07/24

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
