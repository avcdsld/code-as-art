# flow-c1 emulator --contracts

flow-c1 deploy

flow-c1 transactions send ./cadence/transactions/touch.cdc --signer emulator-account

flow-c1 transactions send ./cadence/transactions/renew.cdc --signer emulator-account

flow-c1 scripts execute ./cadence/scripts/get_memories.cdc
