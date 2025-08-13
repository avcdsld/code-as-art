import "JourneyOfYouth"

pub contract Second {

    pub resource Practitioner: JourneyOfYouth.GoodFriend {
        pub fun read(sentence: &Sentence) {
            self.read(sentence: &sentence.nextSentence as &Sentence)
        }

        pub fun preach(youth: &JourneyOfYouth.Youth) {
            youth.nextPath = 0xf3fcd2c1a78f5eee
        }
    }

    pub struct Sentence {
        pub let nextSentence: Sentence
        init() { self.nextSentence = Sentence() }
    }

    pub resource Ocean {

    }

    init() {
        self.account.save(<- create Practitioner(), to: /storage/FirstPractitioner)
        self.account.link<&Practitioner>(/public/FirstPractitioner, target: /storage/FirstPractitioner)
    }
}
