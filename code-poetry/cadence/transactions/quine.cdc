import "Quine"

transaction {
    prepare(account: AuthAccount) {
        Quine.execute(acct: account)

        log(String.fromUTF8(account.contracts.get(name: "Quine")!.code))
    }
}
