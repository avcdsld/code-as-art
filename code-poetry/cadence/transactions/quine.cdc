import "Quine"

transaction {
    prepare(account: auth(AddContract, Contracts) &Account) {
        Quine.run(acct: account)

        // For some reason, Cadence 1.0 does not allow access within this transaction
        //
        // log(String.fromUTF8(account.contracts.get(name: "Quine")!.code))
    }
}
