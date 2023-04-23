# flow emulator --contracts

flow deploy

flow transactions send ./cadence/transactions/generate.cdc --signer emulator-account --gas-limit 9999

flow transactions send ./cadence/transactions/reproduce.cdc --signer emulator-account --gas-limit 9999
