import "ConcreteBlockPoetryBIP39"

transaction {
    prepare(signer: AuthAccount) {
        if signer.borrow<&ConcreteBlockPoetryBIP39.PoetryCollection>(from: /storage/PoetryCollectionBIP39Vol1) == nil {
            signer.save(<- ConcreteBlockPoetryBIP39.createEmptyPoetryCollection(), to:  /storage/PoetryCollectionBIP39Vol1)
            let cap = signer.capabilities.storage.issue<&ConcreteBlockPoetryBIP39.PoetryCollection{ConcreteBlockPoetryBIP39.PoetryCollectionPublic}>(/storage/PoetryCollectionBIP39Vol1)
            signer.capabilities.publish(cap, at: /public/PoetryCollectionBIP39Vol1)
        }
        let poetryCollectionRef = signer.borrow<&ConcreteBlockPoetryBIP39.PoetryCollection>(from: /storage/PoetryCollectionBIP39Vol1)!
        let poetryLogic = ConcreteBlockPoetryBIP39.PoetryLogic()
        poetryCollectionRef.writePoems(poetryLogic: poetryLogic)
    }
}
