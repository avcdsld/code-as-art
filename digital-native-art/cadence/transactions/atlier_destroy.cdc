import "Atelier"

transaction {
    prepare(signer: &Account) {
        let uuids = Atelier.getUUIDs()
        Atelier.destroyArt(uuid: uuids[0])
    }
}
