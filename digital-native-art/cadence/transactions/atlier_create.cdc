import "Atelier"

transaction {
    prepare(signer: &Account) {
        Atelier.createArt()
    }
}
