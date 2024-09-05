# flow-c1 emulator

flow-c1 deploy

flow-c1 transactions send ./cadence/transactions/find_mnemonic.cdc --signer emulator-account

flow-c1 scripts execute ./cadence/scripts/get_mnemonic.cdc f8d6e0586b0a20c7

flow-c1 transactions send ./cadence/transactions/write_poem.cdc "いぜん れんあい てんすう のりゆき これくしょん あたりまえ おじさん ひびく こいびと かわら くとうてん はむかう" "テストポエム テストポエム テストポエム" --signer emulator-account
