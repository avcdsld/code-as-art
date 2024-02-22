import "MediaArts"

transaction {
    prepare(signer: AuthAccount) {
        signer.save(<- MediaArts.create(), to: StoragePath(identifier: "MediaArt1")!)
        signer.save(<- MediaArts.create(), to: StoragePath(identifier: "MediaArt2")!)
        signer.save(<- MediaArts.create(), to: StoragePath(identifier: "MediaArt3")!)
    }
}
