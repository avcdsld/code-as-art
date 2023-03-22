import MetadataViews from "../contracts/MetadataViews.cdc"
import Gift from "../contracts/Gift.cdc"

pub fun main(address: Address, id: UInt64): {Type: AnyStruct?} {
    let collection = getAccount(address).getCapability(Gift.CollectionPublicPath).borrow<&{Gift.GiftCollectionPublic}>() ?? panic("Not Found")
    let nft = collection.borrowGift(id: id)!
    log(nft.isGift())

    let res: {Type: AnyStruct?} = {}
    let types = nft.getViews()
    for type in types {
        res[type] = nft.resolveView(type)
    }
    return res
}
