import "GiftV2"

transaction {
    prepare(signer: auth(BorrowValue, SaveValue, IssueStorageCapabilityController, PublishCapability, GetStorageCapabilityController) &Account) {
        if signer.storage.borrow<&GiftV2.Collection>(from: GiftV2.CollectionStoragePath) == nil {
            signer.storage.save(<- GiftV2.createEmptyCollection(nftType: Type<@GiftV2.NFT>()), to: GiftV2.CollectionStoragePath)
            let cap = signer.capabilities.storage.issue<&GiftV2.Collection>(GiftV2.CollectionStoragePath)
            signer.capabilities.publish(cap, at: GiftV2.CollectionPublicPath)
        }
        let collection = signer.capabilities.get<&GiftV2.Collection>(GiftV2.CollectionPublicPath).borrow() ?? panic("Not Found")
        collection.gift(token: <- GiftV2.mintNFT())
    }
}
