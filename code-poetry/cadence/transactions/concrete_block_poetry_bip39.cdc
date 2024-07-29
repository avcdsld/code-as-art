import "ConcreteBlockPoetryBIP39"

transaction {
    prepare(signer: auth(BorrowValue, IssueStorageCapabilityController, PublishCapability, SaveValue, UnpublishCapability) &Account) {
        if signer.storage.borrow<&ConcreteBlockPoetryBIP39.PoetryCollection>(from: /storage/PoetryCollectionBIP39Vol1) == nil {
            signer.storage.save(<- ConcreteBlockPoetryBIP39.createEmptyPoetryCollection(), to:  /storage/PoetryCollectionBIP39Vol1)
            let cap = signer.capabilities.storage.issue<&ConcreteBlockPoetryBIP39.PoetryCollection>(/storage/PoetryCollectionBIP39Vol1)
            signer.capabilities.publish(cap, at: /public/PoetryCollectionBIP39Vol1)
        }
        let poetryCollectionRef = signer.storage.borrow<auth(ConcreteBlockPoetryBIP39.WritePoem) &ConcreteBlockPoetryBIP39.PoetryCollection>(from: /storage/PoetryCollectionBIP39Vol1)!
        let poetryLogic = ConcreteBlockPoetryBIP39.PoetryLogic()
        poetryCollectionRef.writePoems(poetryLogic: poetryLogic)
    }
}
