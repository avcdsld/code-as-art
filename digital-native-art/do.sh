# flow-c1 emulator

flow-c1 deploy

flow-c1 transactions send ./cadence/transactions/create_and_destroy.cdc --signer emulator-account

flow-c1 transactions send ./cadence/transactions/atlier_create.cdc --signer emulator-account

flow-c1 transactions send ./cadence/transactions/atlier_destroy.cdc --signer emulator-account

flow-c1 scripts execute ./cadence/scripts/get_info.cdc

flow-c1 scripts execute ./cadence/scripts/get_records.cdc 0 10
