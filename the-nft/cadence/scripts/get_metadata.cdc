import MetadataViews from "../contracts/MetadataViews.cdc"
import TheNFT from "../contracts/TheNFT.cdc"

access(all) fun main(address: Address, id: UInt64): {Type: AnyStruct?} {
    let collection = getAccount(address).capabilities.get<&TheNFT.Collection>(TheNFT.CollectionPublicPath).borrow() ?? panic("Not Found")
    let nft = collection.borrowTheNFT(id)!
    log(nft.whatAreYou())

    let res: {Type: AnyStruct?} = {}
    let types = nft.getViews()
    for type in types {
        res[type] = nft.resolveView(type)
    }
    return res
}
