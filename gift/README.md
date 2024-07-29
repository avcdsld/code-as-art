# Gift

A gift is not a gift.

This NFT will not emit Withdraw/Deposit events until it is recognized.
Unless the owner recognizes it himself, external viewers will probably not be able to see it.
Once recognized by the owner, it is no longer a gift.

https://www.flowdiver.io/contract/A.bdbe70269ecb648a.Gift?tab=deployments

---

## Cadence 1.0 Migration 2024/07/28

```sh
sudo sh -ci "$(curl -fsSL https://raw.githubusercontent.com/onflow/flow-cli/master/install.sh)"
flow-c1 version

flow-c1 emulator
flow-c1 deploy

flow-c1 migrate stage Gift --network=mainnet
flow-c1 migrate is-staged Gift --network=mainnet
flow-c1 migrate is-validated Gift --network=mainnet
```
