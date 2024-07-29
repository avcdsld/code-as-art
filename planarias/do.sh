# flow-c1 emulator --contracts

flow-c1 deploy

flow-c1 transactions send ./cadence/transactions/generate.cdc --signer emulator-account --gas-limit 9999

flow-c1 transactions send ./cadence/transactions/reproduce.cdc --signer emulator-account --gas-limit 9999
