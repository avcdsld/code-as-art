import NonFungibleToken from "../contracts/NonFungibleToken.cdc"
import MetadataViews from "../contracts/MetadataViews.cdc"
import Gift from "../contracts/Gift.cdc"

transaction(giftThumbnailUrl: String, notGiftThumbnailUrl: String) {
    prepare(signer: AuthAccount) {
        let maintainer = signer.borrow<&Gift.Maintainer>(from: /storage/GiftMaintainer) ?? panic("Not Found")
        maintainer.setThumbnail(
            giftThumbnail: MetadataViews.HTTPFile(url: giftThumbnailUrl),
            notGiftThumbnail: MetadataViews.HTTPFile(url: notGiftThumbnailUrl)
        )
    }
}
