import "ConcreteBlockPoetry"

transaction {
    prepare(signer: auth(BorrowValue, IssueStorageCapabilityController, PublishCapability, SaveValue, UnpublishCapability) &Account) {
        if signer.storage.borrow<&ConcreteBlockPoetry.PoetryCollection>(from: /storage/PoetryCollectionVol1) == nil {
            signer.storage.save(<- ConcreteBlockPoetry.createEmptyPoetryCollection(), to:  /storage/PoetryCollectionVol1)
            let cap = signer.capabilities.storage.issue<&ConcreteBlockPoetry.PoetryCollection>(/storage/PoetryCollectionVol1)
            signer.capabilities.publish(cap, at: /public/PoetryCollectionVol1)
        }
        let poetryCollectionRef = signer.storage.borrow<auth(ConcreteBlockPoetry.WritePoem) &ConcreteBlockPoetry.PoetryCollection>(from: /storage/PoetryCollectionVol1)!
        let poetryLogic = ConcreteBlockPoetry.PoetryLogic()
        poetryCollectionRef.writePoem(poetryLogic: poetryLogic)
    }
}
