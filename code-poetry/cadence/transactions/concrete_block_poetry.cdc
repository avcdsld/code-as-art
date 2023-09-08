import "ConcreteBlockPoetry"

transaction {
    prepare(signer: AuthAccount) {
        if signer.borrow<&ConcreteBlockPoetry.PoetryCollection>(from: /storage/PoetryCollectionVol1) == nil {
            signer.save(<- ConcreteBlockPoetry.createEmptyPoetryCollection(), to:  /storage/PoetryCollectionVol1)
            let cap = signer.capabilities.storage.issue<&ConcreteBlockPoetry.PoetryCollection{ConcreteBlockPoetry.PoetryCollectionPublic}>(/storage/PoetryCollectionVol1)
            signer.capabilities.publish(cap, at: /public/PoetryCollectionVol1)
        }
        let poetryCollectionRef = signer.borrow<&ConcreteBlockPoetry.PoetryCollection>(from: /storage/PoetryCollectionVol1)!
        let poetryLogic = ConcreteBlockPoetry.PoetryLogic()
        poetryCollectionRef.writePoem(poetryLogic: poetryLogic)
    }
}
