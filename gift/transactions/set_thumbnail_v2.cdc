import "MetadataViews"
import "GiftV2"

transaction(giftThumbnailUrl: String, notGiftThumbnailUrl: String) {
    prepare(signer: auth(BorrowValue) &Account) {
        let maintainer = signer.storage.borrow<&GiftV2.Maintainer>(from: /storage/GiftV2Maintainer) ?? panic("Not Found")
        maintainer.setThumbnail(
            giftThumbnail: MetadataViews.HTTPFile(url: giftThumbnailUrl),
            notGiftThumbnail: MetadataViews.HTTPFile(url: notGiftThumbnailUrl)
        )
    }
}
