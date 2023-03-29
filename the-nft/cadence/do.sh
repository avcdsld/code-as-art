flow deploy

flow transactions send ./transactions/set_base_url.cdc https://us-central1-code-as-art-the-nft.cloudfunctions.net/api/image/ --signer emulator-account

flow transactions send ./transactions/mint.cdc --signer emulator-account

flow scripts execute ./scripts/get_metadata.cdc f8d6e0586b0a20c7 1
