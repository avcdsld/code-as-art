import NonFungibleToken from "../contracts/NonFungibleToken.cdc"
import MetadataViews from "../contracts/MetadataViews.cdc"
import TheNFT from "../contracts/TheNFT.cdc"

transaction {
    prepare(signer: AuthAccount) {
        if signer.borrow<&TheNFT.Collection>(from: TheNFT.CollectionStoragePath) == nil {
            signer.save(<- TheNFT.createEmptyCollection(), to: TheNFT.CollectionStoragePath)
            signer.link<&{NonFungibleToken.CollectionPublic, TheNFT.TheNFTCollectionPublic, MetadataViews.ResolverCollection}>(TheNFT.CollectionPublicPath, target: TheNFT.CollectionStoragePath)
        }
        let collection = signer.getCapability(TheNFT.CollectionPublicPath).borrow<&{TheNFT.TheNFTCollectionPublic}>() ?? panic("Not Found")
        collection.deposit(token: <- TheNFT.mintNFT())
    }
}
