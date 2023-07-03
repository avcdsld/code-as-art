import "UniverseV2"

transaction {
    prepare(signer: AuthAccount) {
        let thing <- UniverseV2.create_thing()
        thing.set_necessary(necessary_or_not: true)
        // thing.set_necessary(necessary_or_not: false)
        destroy thing
    }
}
