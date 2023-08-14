pub contract AllTheDeities {

    pub resource Deity {
        pub let name: String

        init (name: String) {
            self.name = name
        }
    }

    pub resource Creator {
        pub fun create(name: String): @Deity {
            return <- create Deity(name: name)
        }
    }

    init() {
        self.account.save(<- create Creator(), to: /storage/AllTheDeitiesCreator)
        self.account.link<&Creator>(/public/Creator, target: /storage/AllTheDeitiesCreator)
    }
}
