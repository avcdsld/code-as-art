import "MediaArts"

transaction {
    prepare(signer: auth(SaveValue) &Account) {
        signer.storage.save(<- MediaArts.createMediaArt(), to: StoragePath(identifier: "MediaArt1")!)
        signer.storage.save(<- MediaArts.createMediaArt(), to: StoragePath(identifier: "MediaArt2")!)
        signer.storage.save(<- MediaArts.createMediaArt(), to: StoragePath(identifier: "MediaArt3")!)
    }
}
