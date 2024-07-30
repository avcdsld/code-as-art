import "Gift"

transaction {
    prepare(signer: auth(BorrowValue, SaveValue, IssueStorageCapabilityController, PublishCapability, GetStorageCapabilityController) &Account) {
        if signer.storage.borrow<&Gift.Collection>(from: Gift.CollectionStoragePath) == nil {
            signer.storage.save(<- Gift.createEmptyCollection(nftType: Type<@Gift.NFT>()), to: Gift.CollectionStoragePath)
            let cap = signer.capabilities.storage.issue<&Gift.Collection>(Gift.CollectionStoragePath)
            signer.capabilities.publish(cap, at: Gift.CollectionPublicPath)
        }
        let collection = signer.capabilities.get<&Gift.Collection>(Gift.CollectionPublicPath).borrow() ?? panic("Not Found")
        collection.deposit(token: <- Gift.mintNFT())
    }
}
