import "Waterfalls"

transaction {
    prepare(signer: AuthAccount) {
        let waterfall <- Waterfalls.create(wall: 0)
        let carp <- waterfall.hatch()
        let dragon <- waterfall.climb(carp: <- carp)
        destroy waterfall
        signer.save(<- dragon, to: /storage/WaterfallsDragon)
    }
}
