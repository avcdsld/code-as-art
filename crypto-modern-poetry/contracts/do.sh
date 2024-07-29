# flow-c1 emulator

flow-c1 deploy

flow-c1 transactions send ./cadence/transactions/find_mnemonic.cdc --signer emulator-account

flow-c1 transactions send ./cadence/transactions/write_poem.cdc "いぜん れんあい てんすう のりゆき これくしょん あたりまえ おじさん ひびく こいびと かわら くとうてん はむかう" "テストポエム テストポエム テストポエム" --signer emulator-account
