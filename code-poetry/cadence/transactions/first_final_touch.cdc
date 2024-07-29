import "FirstFinalTouch"

transaction {
    prepare(signer: &Account) {
        FirstFinalTouch.finalize()
    }
}
