# flow emulator

flow deploy

flow transactions send ./cadence/transactions/find_mnemonic.cdc --signer emulator-account

flow transactions send ./cadence/transactions/write_poem.cdc "のきなみ そんぞく あんまり こすう となえる ぬいくぎ にっき ぴっちり せんい こたつ さんせい けんとう" "テストポエム テストポエム テストポエム" --signer emulator-account
