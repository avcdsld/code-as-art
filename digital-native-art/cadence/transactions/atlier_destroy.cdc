import "Atelier"

transaction {
    prepare(signer: AuthAccount) {
        let uuids = Atelier.getUUIDs()
        Atelier.destroyArt(uuid: uuids[0])
    }
}
