import "DigitalNativeArt"

transaction {

    prepare(signer: AuthAccount) {

        // This is the first creation of an `Art` resource object in the digital world.
        var art <- DigitalNativeArt.create()

        // This is the first destruction of an `Art` resource object in the digital world.
        destroy art
    }
}
