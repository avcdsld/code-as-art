import "ShipOfTheseus"

transaction {
    prepare(signer: AuthAccount) {
        ShipOfTheseus.touch(executor: &signer as &AuthAccount)
    }
}
