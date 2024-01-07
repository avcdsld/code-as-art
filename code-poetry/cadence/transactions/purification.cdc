import "Purification"

transaction {
    prepare(account: AuthAccount) {
        let human <- Purification.birth()
        human.live()
        human.live()
        human.live()
        Purification.purify(human: &human as &Purification.Human)
        account.save(<- human, to: /storage/PurificationHuman)
    }
}
