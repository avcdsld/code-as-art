import "NonFungibleToken"
import "MetadataViews"
import "TheNFT"

transaction(baseUrl: String) {
    prepare(signer: auth(BorrowValue) &Account) {
        let maintainer = signer.storage.borrow<&TheNFT.Maintainer>(from: /storage/TheNFTMaintainer) ?? panic("Not Found")
        maintainer.setBaseUrl(url: baseUrl)
    }
}
