pub contract DigitalNativeArt {

    pub resource Art {
        // This is the first resource named `Art` in the digital world.
    }

    pub fun create(): @Art {
        return <- create Art()
    }
}
