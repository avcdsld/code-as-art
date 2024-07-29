access(all) contract DigitalNativeArt {

    access(all) resource Art {
        // This is the first resource named `Art` in the digital world.
    }

    access(all) fun createArt(): @Art {
        return <- create Art()
    }
}
