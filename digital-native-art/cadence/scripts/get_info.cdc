import "Atelier"

access(all) struct Info {
    access(all) let creations: UInt64
    access(all) let destructions: UInt64

    init(creations: UInt64, destructions: UInt64) {
        self.creations = creations
        self.destructions = destructions
    }
}

access(all) fun main(): Info {
    return Info(
        creations: Atelier.creations,
        destructions: Atelier.destructions
    )
}
