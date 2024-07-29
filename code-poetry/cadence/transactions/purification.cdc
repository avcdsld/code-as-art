import "Purification"

transaction {
    prepare(account: auth(SaveValue) &Account) {
        let human <- Purification.birth()
        human.live()
        human.live()
        human.live()
        Purification.purify(human: &human as &Purification.Human)
        account.storage.save(<- human, to: /storage/PurificationHuman)
    }
}
