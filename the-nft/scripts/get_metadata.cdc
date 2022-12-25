import MetadataViews from "../contracts/MetadataViews.cdc"
import TheNFT from "../contracts/TheNFT.cdc"

pub fun main(address: Address, id: UInt64): {Type: AnyStruct?} {
    let collection = getAccount(address).getCapability(TheNFT.CollectionPublicPath).borrow<&{TheNFT.TheNFTCollectionPublic}>() ?? panic("Not Found")
    let nft = collection.borrowTheNFT(id: id)!
    log(nft.whatAreYou())

    let res: {Type: AnyStruct?} = {}
    let types = nft.getViews()
    for type in types {
        res[type] = nft.resolveView(type)
    }
    return res
}
