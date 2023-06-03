# flow emulator

flow deploy

flow transactions send ./cadence/transactions/create_and_destroy.cdc --signer emulator-account

flow transactions send ./cadence/transactions/atlier_create.cdc --signer emulator-account

flow transactions send ./cadence/transactions/atlier_create_and_destroy.cdc --signer emulator-account

flow scripts execute ./cadence/scripts/get_info.cdc

flow scripts execute ./cadence/scripts/get_records.cdc 0 10
