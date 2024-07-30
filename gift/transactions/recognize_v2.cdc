import "GiftV2"

transaction(id: UInt64) {
    prepare(signer: auth(BorrowValue) &Account) {
        let collection = signer.storage.borrow<&GiftV2.Collection>(from: GiftV2.CollectionStoragePath) ?? panic("Not Found")
        let gift = collection.borrowGift(id)!
        gift.recognize()
    }
}
