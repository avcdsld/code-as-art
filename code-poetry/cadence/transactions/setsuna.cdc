import "Setsuna"

transaction {
    prepare(acct: &Account) {
        Setsuna.ikiru()
    }
}
