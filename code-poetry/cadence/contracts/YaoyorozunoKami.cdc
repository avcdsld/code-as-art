access(all) contract YaoyorozunoKami {

    access(all) resource Kami {
        access(all) let name: String
        init (name: String) { self.name = name }
    }

    access(all) resource Creator {
        access(all) fun createKami(name: String): @Kami {
            return <- create Kami(name: name)
        }
    }

    init() {
        self.account.storage.save(<- create Creator(), to: /storage/Creator)
        let cap = self.account.capabilities.storage.issue<&Creator>(/storage/Creator)
        self.account.capabilities.publish(cap, at: /public/Creator)
    }
}
