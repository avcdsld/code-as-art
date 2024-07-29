import "ActualInfinity"

transaction {
    prepare(signer: auth(SaveValue) &Account) {
        let creativity <- ActualInfinity.Create()
        signer.storage.save(<- creativity, to: StoragePath(identifier: "ActualInfinity")!)
    }
}
