access(all) contract UniverseV2 {

    access(all) resource Thing {
        access(all) var is_necessary: Bool

        init() {
            self.is_necessary = true
        }

        access(all) fun set_necessary(necessary_or_not: Bool) {
            pre {
                necessary_or_not == true: "Nothing is unnecessary in the universe."
            }
            self.is_necessary = necessary_or_not
        }
    }

    access(all) fun create_thing(): @Thing {
        return <- create Thing()
    }
}
