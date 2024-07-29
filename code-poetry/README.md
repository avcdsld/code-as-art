# Code Poetry

## Deployment Info

- Universe: https://www.flowdiver.io/contract/A.23b08a725bc2533d.Universe

- NeverEndingStory: https://www.flowdiver.io/contract/A.23b08a725bc2533d.NeverEndingStory

- StudyOfThings: https://www.flowdiver.io/contract/A.23b08a725bc2533d.StudyOfThings

- Metabolism: https://www.flowdiver.io/contract/A.23b08a725bc2533d.Metabolism

- Tanabata: https://www.flowdiver.io/contract/A.23b08a725bc2533d.Tanabata
    - https://www.flowdiver.io/tx/71f3a61c1cf3bf53fa7e155f4a7ec6ebbe16bb640fefc72906a0c9c0ee20dd98

- YaoyorozunoKami: https://www.flowdiver.io/contract/A.23b08a725bc2533d.YaoyorozunoKami
    - https://www.flowdiver.io/tx/f664cebce1ed068b508a9c2ce3271e8fbb2020e997765412cc6986759aa9f9e7

- ObjectOrientedOntology: https://www.flowdiver.io/contract/A.23b08a725bc2533d.ObjectOrientedOntology/overview
    - https://www.flowdiver.io/tx/f4e7dd7d614a8c19a26f252ec16b388276b7202a9908eda50e0821a891236cad

- Deity (on Sui): https://suiexplorer.com/object/0x489a3e27f1e6f4e3e009cbf40223c077123266210bc086c979aa5e4e3a0d4cbb?network=mainnet

- Deity (on Flow): https://www.flowdiver.io/contract/A.23b08a725bc2533d.Deities

- Code is NOT Law:
    - https://etherscan.io/address/0x695dde21412fd806dd59a510bbabf8a6bb485a87#code
    - https://etherscan.io/address/0x7b8a994a5f1912e8ce55bd5800716869e6d14bfd#code

- ConcreteAlphabets: https://www.flowdiver.io/contract/A.23b08a725bc2533d.ConcreteAlphabets
    - https://www.flowdiver.io/tx/1a19e1211f18b60352666566944ac6f60b1fe8065670acf0bcc6d3cf4bbb8e7c

- ConcreteBlockPoetry: https://www.flowdiver.io/contract/A.23b08a725bc2533d.ConcreteBlockPoetry

- ConcreteBlockPoetryBIP39: https://www.flowdiver.io/contract/A.23b08a725bc2533d.ConcreteBlockPoetryBIP39

- BIP39WordList: https://www.flowdiver.io/contract/A.23b08a725bc2533d.BIP39WordList

- ActualInfinity: https://www.flowdiver.io/contract/A.23b08a725bc2533d.ActualInfinity

- RoyaltEffects: https://www.flowdiver.io/contract/A.23b08a725bc2533d.RoyaltEffects

- Quine: https://www.flowdiver.io/contract/A.23b08a725bc2533d.Quine

- EffectiveLifeTime: https://www.flowdiver.io/contract/A.23b08a725bc2533d.EffectiveLifeTime
    - https://www.flowdiver.io/tx/a488c5a5cffa2d2abd33a3f5333a11b7845398a6c3f537843135fc6339857a50

- Setsuna: https://www.flowdiver.io/contract/A.23b08a725bc2533d.Setsuna
    - https://www.flowdiver.io/tx/bfdab9517030fe9fb46e86530ad9314370f3ffb1a3b0d4434e71434b3cd82672

- Waterfalls: https://www.flowdiver.io/contract/A.23b08a725bc2533d.Waterfalls
    - https://www.flowdiver.io/tx/e2e92674b9e983d708e8c0e3ef74dff6e67bd95c100f9b1e178d0238d13d2da7

- Purification: https://www.flowdiver.io/contract/A.23b08a725bc2533d.Purification
    - https://www.flowdiver.io/tx/a2190043a284885c63e77bce769543f09cf518c824885e0ff775a1db5053ad16

- FirstFinalTouch: https://www.flowdiver.io/contract/A.23b08a725bc2533d.FirstFinalTouch

- DeepSea: https://www.flowdiver.io/contract/A.23b08a725bc2533d.DeepSea
    - https://www.flowdiver.io/tx/387f869465b689589276ab5c0fdcb8cf60b37a5405aa5f10bcc26ae08498638a

## Cadence 1.0 Migration 2024/07/24

```sh
sudo sh -ci "$(curl -fsSL https://raw.githubusercontent.com/onflow/flow-cli/master/install.sh)"
flow-c1 version

flow-c1 emulator
flow-c1 deploy

flow-c1 migrate stage ActualInfinity --network=mainnet
flow-c1 migrate is-staged ActualInfinity --network=mainnet
flow-c1 migrate is-validated ActualInfinity --network=mainnet

flow-c1 migrate stage BIP39WordList --network=mainnet
flow-c1 migrate is-staged BIP39WordList --network=mainnet
flow-c1 migrate is-validated BIP39WordList --network=mainnet

flow-c1 migrate stage ConcreteAlphabets --network=mainnet
flow-c1 migrate is-staged ConcreteAlphabets --network=mainnet
flow-c1 migrate is-validated ConcreteAlphabets --network=mainnet

flow-c1 migrate stage ConcreteAlphabetsFrench --network=mainnet
flow-c1 migrate is-staged ConcreteAlphabetsFrench --network=mainnet
flow-c1 migrate is-validated ConcreteAlphabetsFrench --network=mainnet

flow-c1 migrate stage ConcreteAlphabetsHangle --network=mainnet
flow-c1 migrate is-staged ConcreteAlphabetsHangle --network=mainnet
flow-c1 migrate is-validated ConcreteAlphabetsHangle --network=mainnet

flow-c1 migrate stage ConcreteAlphabetsHiragana --network=mainnet
flow-c1 migrate is-staged ConcreteAlphabetsHiragana --network=mainnet
flow-c1 migrate is-validated ConcreteAlphabetsHiragana --network=mainnet

flow-c1 migrate stage ConcreteAlphabetsSimplifiedChinese --network=mainnet
flow-c1 migrate is-staged ConcreteAlphabetsSimplifiedChinese --network=mainnet
flow-c1 migrate is-validated ConcreteAlphabetsSimplifiedChinese --network=mainnet

flow-c1 migrate stage ConcreteAlphabetsSpanish --network=mainnet
flow-c1 migrate is-staged ConcreteAlphabetsSpanish --network=mainnet
flow-c1 migrate is-validated ConcreteAlphabetsSpanish --network=mainnet

flow-c1 migrate stage ConcreteAlphabetsTraditionalChinese --network=mainnet
flow-c1 migrate is-staged ConcreteAlphabetsTraditionalChinese --network=mainnet
flow-c1 migrate is-validated ConcreteAlphabetsTraditionalChinese --network=mainnet

flow-c1 migrate stage ConcreteBlockPoetry --network=mainnet
flow-c1 migrate is-staged ConcreteBlockPoetry --network=mainnet
flow-c1 migrate is-validated ConcreteBlockPoetry --network=mainnet

flow-c1 migrate stage ConcreteBlockPoetryBIP39 --network=mainnet
flow-c1 migrate is-staged ConcreteBlockPoetryBIP39 --network=mainnet
flow-c1 migrate is-validated ConcreteBlockPoetryBIP39 --network=mainnet

flow-c1 migrate stage DateUtil --network=mainnet
flow-c1 migrate is-staged DateUtil --network=mainnet
flow-c1 migrate is-validated DateUtil --network=mainnet

flow-c1 migrate stage DeepSea --network=mainnet
flow-c1 migrate is-staged DeepSea --network=mainnet
flow-c1 migrate is-validated DeepSea --network=mainnet

flow-c1 migrate stage Deities --network=mainnet
flow-c1 migrate is-staged Deities --network=mainnet
flow-c1 migrate is-validated Deities --network=mainnet

flow-c1 migrate stage EffectiveLifeTime --network=mainnet
flow-c1 migrate is-staged EffectiveLifeTime --network=mainnet
flow-c1 migrate is-validated EffectiveLifeTime --network=mainnet

flow-c1 migrate stage FirstFinalTouch --network=mainnet
flow-c1 migrate is-staged FirstFinalTouch --network=mainnet
flow-c1 migrate is-validated FirstFinalTouch --network=mainnet

flow-c1 migrate stage MediaArts --network=mainnet
flow-c1 migrate is-staged MediaArts --network=mainnet
flow-c1 migrate is-validated MediaArts --network=mainnet

flow-c1 migrate stage Metabolism --network=mainnet
flow-c1 migrate is-staged Metabolism --network=mainnet
flow-c1 migrate is-validated Metabolism --network=mainnet

flow-c1 migrate stage NeverEndingStory --network=mainnet
flow-c1 migrate is-staged NeverEndingStory --network=mainnet
flow-c1 migrate is-validated NeverEndingStory --network=mainnet

flow-c1 migrate stage ObjectOrientedOntology --network=mainnet
flow-c1 migrate is-staged ObjectOrientedOntology --network=mainnet
flow-c1 migrate is-validated ObjectOrientedOntology --network=mainnet

flow-c1 migrate stage Purification --network=mainnet
flow-c1 migrate is-staged Purification --network=mainnet
flow-c1 migrate is-validated Purification --network=mainnet

flow-c1 migrate stage Quine --network=mainnet
flow-c1 migrate is-staged Quine --network=mainnet
flow-c1 migrate is-validated Quine --network=mainnet

flow-c1 migrate stage RoyaltEffects --network=mainnet
flow-c1 migrate is-staged RoyaltEffects --network=mainnet
flow-c1 migrate is-validated RoyaltEffects --network=mainnet

flow-c1 migrate stage Setsuna --network=mainnet
flow-c1 migrate is-staged Setsuna --network=mainnet
flow-c1 migrate is-validated Setsuna --network=mainnet

flow-c1 migrate stage StudyOfThings --network=mainnet
flow-c1 migrate is-staged StudyOfThings --network=mainnet
flow-c1 migrate is-validated StudyOfThings --network=mainnet

flow-c1 migrate stage Tanabata --network=mainnet
flow-c1 migrate is-staged Tanabata --network=mainnet
flow-c1 migrate is-validated Tanabata --network=mainnet

flow-c1 migrate stage UndefinedCode --network=mainnet
flow-c1 migrate is-staged UndefinedCode --network=mainnet
flow-c1 migrate is-validated UndefinedCode --network=mainnet

flow-c1 migrate stage Universe --network=mainnet
flow-c1 migrate is-staged Universe --network=mainnet
flow-c1 migrate is-validated Universe --network=mainnet

flow-c1 migrate stage Waterfalls --network=mainnet
flow-c1 migrate is-staged Waterfalls --network=mainnet
flow-c1 migrate is-validated Waterfalls --network=mainnet

flow-c1 migrate stage YaoyorozunoKami --network=mainnet
flow-c1 migrate is-staged YaoyorozunoKami --network=mainnet
flow-c1 migrate is-validated YaoyorozunoKami --network=mainnet

```
