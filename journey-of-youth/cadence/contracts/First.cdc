import "JourneyOfYouth"

pub contract First {

    pub resource Practitioner: JourneyOfYouth.GoodFriend {
        pub fun concentrate(buddhas: [&AnyResource]) {
            for buddha in buddhas {
                log(buddha.getType())
            }
        }

        pub fun preach(youth: &JourneyOfYouth.Youth) {
            youth.nextPath = 0xf3fcd2c1a78f5eee
        }
    }

    init() {
        self.account.save(<- create Practitioner(), to: /storage/FirstPractitioner)
        self.account.link<&Practitioner>(/public/FirstPractitioner, target: /storage/FirstPractitioner)
    }
}
