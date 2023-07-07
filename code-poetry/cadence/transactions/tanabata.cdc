import "Tanabata"

transaction {
    prepare(signer: AuthAccount) {
        Tanabata.fulfill(wish: "world peace")
    }
}
