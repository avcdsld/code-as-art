import NonFungibleToken from "../contracts/NonFungibleToken.cdc"
import MetadataViews from "../contracts/MetadataViews.cdc"
import TheNFT from "../contracts/TheNFT.cdc"

transaction(baseUrl: String) {
    prepare(signer: AuthAccount) {
        let maintainer = signer.borrow<&TheNFT.Maintainer>(from: /storage/TheNFTMaintainer) ?? panic("Not Found")
        maintainer.setBaseUrl(url: baseUrl)
    }
}
