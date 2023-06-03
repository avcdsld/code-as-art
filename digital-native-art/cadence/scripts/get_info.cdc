import "Atelier"

pub struct Info {
    pub let creations: UInt64
    pub let destructions: UInt64

    init(creations: UInt64, destructions: UInt64) {
        self.creations = creations
        self.destructions = destructions
    }
}

pub fun main(): Info {
    return Info(
        creations: Atelier.creations,
        destructions: Atelier.destructions
    )
}
