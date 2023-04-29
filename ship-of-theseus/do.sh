# flow emulator --contracts

flow deploy

flow transactions send ./cadence/transactions/touch.cdc --signer emulator-account

flow transactions send ./cadence/transactions/renew.cdc --signer emulator-account

flow scripts execute ./cadence/scripts/get_memories.cdc
