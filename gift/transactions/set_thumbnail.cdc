import "NonFungibleToken"
import "MetadataViews"
import "Gift"

transaction(giftThumbnailUrl: String, notGiftThumbnailUrl: String) {
    prepare(signer: auth(BorrowValue) &Account) {
        let maintainer = signer.storage.borrow<&Gift.Maintainer>(from: /storage/GiftMaintainer) ?? panic("Not Found")
        maintainer.setThumbnail(
            giftThumbnail: MetadataViews.HTTPFile(url: giftThumbnailUrl),
            notGiftThumbnail: MetadataViews.HTTPFile(url: notGiftThumbnailUrl)
        )
    }
}
