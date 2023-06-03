import "Atelier"

transaction {
    prepare(signer: AuthAccount) {
        Atelier.createArt()
    }
}
