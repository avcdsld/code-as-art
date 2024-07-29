access(all) contract NeverEndingStory {

    access(all) resource Story {
        // The code that worked in Cadence 0.42 does not work in Cadence 1.0. The NeverEnding story has come to an end.
        //
        // destroy() {
        //     panic("The Nothing")
        // }
    }

    init() {
        self.account.storage.save(<- create Story(), to: /storage/NeverEndingStory)
    }
}
