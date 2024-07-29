# Fountain

> Der römische Brunnen / The Roman Fountain
> 
> Der Springquell plätschert und ergießt
> Sich in der Marmorschale Grund,
> Die, sich verschleiernd, überfließt
> In einer zweiten Schale Rund;
> Und diese gibt, sie wird zu reich,
> Der dritten wallend ihre Flut,
> Und jede nimmt und gibt zugleich,
> Und alles strömt und alles ruht.
> 
> ― C. F. Meyer, 1870

https://www.flowdiver.io/contract/A.23b08a725bc2533d.Fountain?tab=deployments


## Cadence 1.0 Migration 2024/07/24

```sh
sudo sh -ci "$(curl -fsSL https://raw.githubusercontent.com/onflow/flow-cli/master/install.sh)"
flow-c1 version

flow-c1 emulator
flow-c1 deploy

flow-c1 migrate stage Fountain --network=mainnet
flow-c1 migrate is-staged Fountain --network=mainnet
flow-c1 migrate is-validated Fountain --network=mainnet
```
