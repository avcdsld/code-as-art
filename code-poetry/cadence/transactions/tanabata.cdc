import "Tanabata"

transaction {
    prepare(signer: &Account) {
        Tanabata.fulfill(wish: "world peace")
    }
}
