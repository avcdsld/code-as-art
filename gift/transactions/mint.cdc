import NonFungibleToken from "../contracts/NonFungibleToken.cdc"
import MetadataViews from "../contracts/MetadataViews.cdc"
import Gift from "../contracts/Gift.cdc"

transaction {
    prepare(signer: AuthAccount) {
        if signer.borrow<&Gift.Collection>(from: Gift.CollectionStoragePath) == nil {
            signer.save(<- Gift.createEmptyCollection(), to: Gift.CollectionStoragePath)
            signer.link<&{NonFungibleToken.CollectionPublic, Gift.GiftCollectionPublic, MetadataViews.ResolverCollection}>(Gift.CollectionPublicPath, target: Gift.CollectionStoragePath)
        }
        let collection = signer.getCapability(Gift.CollectionPublicPath).borrow<&{Gift.GiftCollectionPublic}>() ?? panic("Not Found")
        collection.deposit(token: <- Gift.mintNFT())
    }
}
