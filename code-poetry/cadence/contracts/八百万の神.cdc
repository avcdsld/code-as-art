pub contract 八百万の神 {

    pub resource 神 {
        pub let name: String
 
        init (name: String) {
            self.name = name
        }
    }

    pub resource 創造主 {
        pub fun create(name: String): @神 {
            return <- create 神(name: name)
        }
    }

    init() {
        self.account.save(<- create 創造主(), to: /storage/Creator)
        self.account.link<&創造主>(/public/Creator, target: /storage/Creator)
    }
}
