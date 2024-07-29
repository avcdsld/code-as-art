import "MnemonicPoetry"

transaction {
    prepare(signer: auth(BorrowValue, SaveValue, StorageCapabilities, PublishCapability) &Account) {
        if signer.storage.borrow<&MnemonicPoetry.PoetryCollection>(from: /storage/MnemonicPoetryCollection) == nil {
            signer.storage.save(<- MnemonicPoetry.createEmptyPoetryCollection(), to:  /storage/MnemonicPoetryCollection)
            let cap = signer.capabilities.storage.issue<&MnemonicPoetry.PoetryCollection>(/storage/MnemonicPoetryCollection)
            signer.capabilities.publish(cap, at: /public/MnemonicPoetryCollection)
        }
        let poetryCollectionRef = signer.storage.borrow<&MnemonicPoetry.PoetryCollection>(from: /storage/MnemonicPoetryCollection)!
        let mnemonic = poetryCollectionRef.findMnemonic()
        log(mnemonic.words)
    }
}
