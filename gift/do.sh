# flow-c1 emulator

flow-c1 deploy --update

flow-c1 transactions send ./transactions/mint.cdc --signer emulator-account

flow-c1 scripts execute ./scripts/get_metadata.cdc f8d6e0586b0a20c7 1

flow-c1 transactions send ./transactions/set_thumbnail.cdc https://nftstorage.link/ipfs/bafkreicmoh2ummsp4qgyp6fvk7lj7uy44jmnymhl6v75h5bbexf5i6njdm https://nftstorage.link/ipfs/bafkreiftdj3uj25a4tdnofc3ht6ir2pftwbn2dvtxsajj3rzkrsbdvkkqi --signer emulator-account

flow-c1 transactions send ./transactions/recognize.cdc 1 --signer emulator-account

flow-c1 scripts execute ./scripts/get_metadata.cdc f8d6e0586b0a20c7 1
