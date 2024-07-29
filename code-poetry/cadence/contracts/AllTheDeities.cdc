access(all) contract AllTheDeities {

    access(all) resource Deity {
        access(all) let name: String

        init (name: String) {
            self.name = name
        }
    }

    access(all) resource Creator {
        access(all) fun create(name: String): @Deity {
            return <- create Deity(name: name)
        }
    }

    init() {
        self.account.save(<- create Creator(), to: /storage/AllTheDeitiesCreator)
        self.account.link<&Creator>(/public/Creator, target: /storage/AllTheDeitiesCreator)
    }
}
