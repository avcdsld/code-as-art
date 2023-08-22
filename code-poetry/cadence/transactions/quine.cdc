import "Quine"

transaction {
    prepare(account: AuthAccount) {
        Quine.run(account: account)
    }
}
