import "ShipOfTheseus"

transaction {
    prepare(signer: &Account) {
        ShipOfTheseus.touch(executor: signer)
    }
}
