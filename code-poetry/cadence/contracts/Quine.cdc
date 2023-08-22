pub contract Quine {
    pub fun run(account: AuthAccount) {
        account.contracts.add(
            name: "Quine",
            code: self.account.contracts.get(name: "Quine")!.code
        )
    }
}
