import "RoyaltEffects"

transaction {
    prepare(account: AuthAccount) {
        let nft <- RoyaltEffects.createNFT(price: 100.0)
        log(nft.price)

        nft.enableRoyalty(expectedTotalRoyalty: 50.0)
        log(nft.price)

        destroy nft
    }
}
