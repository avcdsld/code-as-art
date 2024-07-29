# Ship of Theseus

Can we say that objects with the same properties but different UUIDs are the same thing? Of the flowing river the flood ever changeth, on the still pool the foam gathering, vanishing, stayeth not. Such too is the lot of men and of the dwellings of men in this world of ours.

同じプロパティを持つが UUID が異なるオブジェクトは、同じモノだと言えるでしょうか？ゆく河の流れは絶えずして、しかも、もとの水にあらず。淀みに浮かぶうたかたはかつ消えかつ結びて、久しくとどまりたるためしなし。世の中にある人と栖とまたかくのごとし。

https://www.flowdiver.io/contract/A.569087b50ab30c2a.ShipOfTheseus?tab=deployments


## Cadence 1.0 Migration 2024/07/24

```sh
sudo sh -ci "$(curl -fsSL https://raw.githubusercontent.com/onflow/flow-cli/master/install.sh)"
flow-c1 version

flow-c1 emulator
flow-c1 deploy

flow-c1 migrate stage ShipOfTheseus --network=mainnet
flow-c1 migrate is-staged ShipOfTheseus --network=mainnet
flow-c1 migrate is-validated ShipOfTheseus --network=mainnet

flow-c1 migrate stage ShipOfTheseusWarehouse --network=mainnet
flow-c1 migrate is-staged ShipOfTheseusWarehouse --network=mainnet
flow-c1 migrate is-validated ShipOfTheseusWarehouse --network=mainnet
```
