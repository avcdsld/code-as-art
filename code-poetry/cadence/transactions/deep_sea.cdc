import "DeepSea"

transaction {
    prepare(signer: AuthAccount) {
        let deepSea <- DeepSea.dive()
        signer.save(<- deepSea, to: /storage/DeepSea)
    }
}
