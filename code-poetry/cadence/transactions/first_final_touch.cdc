import "FirstFinalTouch"

transaction {
    prepare(signer: AuthAccount) {
        FirstFinalTouch.finalize()
    }
}
