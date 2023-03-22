import NonFungibleToken from "../contracts/NonFungibleToken.cdc"
import MetadataViews from "../contracts/MetadataViews.cdc"
import Gift from "../contracts/Gift.cdc"

transaction(id: UInt64) {
    prepare(signer: AuthAccount) {
        let collection = signer.borrow<&Gift.Collection>(from: Gift.CollectionStoragePath) ?? panic("Not Found")
        let gift = collection.borrowGift(id: id)!
        gift.recognize()
    }
}
