import "Gift"

access(all) fun main(address: Address, id: UInt64): {Type: AnyStruct?} {
    let collection = getAccount(address).capabilities.get<&Gift.Collection>(Gift.CollectionPublicPath).borrow() ?? panic("Not Found")
    let nft = collection.borrowGift(id)!
    log(nft.isGift())

    let res: {Type: AnyStruct?} = {}
    let types = nft.getViews()
    for type in types {
        res[type] = nft.resolveView(type)
    }
    return res
}
