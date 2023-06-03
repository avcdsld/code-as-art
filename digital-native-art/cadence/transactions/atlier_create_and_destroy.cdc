import "Atelier"

transaction {
    prepare(signer: AuthAccount) {
        let uuid = Atelier.createArt()
        Atelier.destroyArt(uuid: uuid)
    }
}
