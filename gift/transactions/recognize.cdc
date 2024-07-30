import "Gift"

transaction(id: UInt64) {
    prepare(signer: auth(BorrowValue) &Account) {
        let collection = signer.storage.borrow<&Gift.Collection>(from: Gift.CollectionStoragePath) ?? panic("Not Found")
        let gift = collection.borrowGift(id)!
        gift.recognize()
    }
}
