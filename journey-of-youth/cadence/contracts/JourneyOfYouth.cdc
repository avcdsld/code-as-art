pub contract JourneyOfYouth {

    pub event Begin(youthName: String)

    pub resource Youth {
        pub(set) var name: String
        pub(set) var nextPath: Address?

        init(name: String) {
            self.name = name
            self.nextPath = nil
        }
    }

    pub resource Sage {
        pub fun preach(youth: &Youth) {
            youth.nextPath = 0xf3fcd2c1a78f5eee
        }
    }

    pub resource interface GoodFriend {}

    pub fun begin(name: String): @Youth {
        emit Begin(youthName: name)
        return <- create Youth(name: name)
    }

    init() {
        self.account.save(<- create Sage(), to: /storage/Sage)
    }
}
