import "ActualInfinity"

transaction {
    prepare(signer: AuthAccount) {
        let creativity <- ActualInfinity.create()
        signer.save(<- creativity, to: StoragePath(identifier: "ActualInfinity")!)
    }
}
