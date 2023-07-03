pub contract UniverseV2 {

    pub resource Thing {
        pub var is_necessary: Bool

        init() {
            self.is_necessary = true
        }

        pub fun set_necessary(necessary_or_not: Bool) {
            pre {
                necessary_or_not == true: "Nothing is unnecessary in the universe."
            }
            self.is_necessary = necessary_or_not
        }
    }

    pub fun create_thing(): @Thing {
        return <- create Thing()
    }
}
