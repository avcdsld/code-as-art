import "DeepSea"

transaction {
    prepare(signer: auth(SaveValue) &Account) {
        let deepSea <- DeepSea.dive()
        signer.storage.save(<- deepSea, to: /storage/DeepSea)
    }
}
