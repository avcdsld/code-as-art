import "Setsuna"

transaction {
    prepare(acct: AuthAccount) {
        Setsuna.ikiru()
    }
}
