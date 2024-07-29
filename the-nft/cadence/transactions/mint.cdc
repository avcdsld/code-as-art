import NonFungibleToken from "../contracts/NonFungibleToken.cdc"
import MetadataViews from "../contracts/MetadataViews.cdc"
import TheNFT from "../contracts/TheNFT.cdc"

transaction {
    prepare(signer: auth(BorrowValue, SaveValue, PublishCapability, IssueStorageCapabilityController) &Account) {
        if signer.storage.borrow<&TheNFT.Collection>(from: TheNFT.CollectionStoragePath) == nil {
            signer.storage.save(<- TheNFT.createEmptyCollection(nftType: Type<@TheNFT.NFT>()), to: TheNFT.CollectionStoragePath)
            let cap = signer.capabilities.storage.issue<&TheNFT.Collection>(TheNFT.CollectionStoragePath)
            signer.capabilities.publish(cap, at: TheNFT.CollectionPublicPath)
        }
        let collection = signer.capabilities.get<&TheNFT.Collection>(TheNFT.CollectionPublicPath).borrow() ?? panic("Not Found")
        collection.deposit(token: <- TheNFT.mintNFT())
    }
}
