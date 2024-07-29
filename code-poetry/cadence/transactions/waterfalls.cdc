import "Waterfalls"

transaction {
    prepare(signer: auth(SaveValue) &Account) {
        let waterfall <- Waterfalls.createWaterfall(wall: 0)
        let carp <- waterfall.hatch()
        let dragon <- waterfall.climb(carp: <- carp)
        destroy waterfall
        signer.storage.save(<- dragon, to: /storage/WaterfallsDragon)
    }
}
