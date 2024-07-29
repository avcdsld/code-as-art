access(all) contract 八百万の神 {

    access(all) resource 神 {
        access(all) let name: String
 
        init (name: String) {
            self.name = name
        }
    }

    access(all) resource 創造主 {
        access(all) fun create(name: String): @神 {
            return <- create 神(name: name)
        }
    }

    init() {
        self.account.save(<- create 創造主(), to: /storage/Creator)
        self.account.link<&創造主>(/public/Creator, target: /storage/Creator)
    }
}
