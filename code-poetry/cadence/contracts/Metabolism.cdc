access(all) contract Metabolism {

    access(all) resource Cell {

        access(all) var is_dead: Bool

        init() {
            self.is_dead = false
        }

        // The code that worked in Cadence 0.42 does not work in Cadence 1.0. Apoptosis is dead.
        //
        // destroy() {
        //     assert(self.is_dead, message: "Not dead yet.")
        // }

        access(all) fun kill(): @Cell {
            self.is_dead = true
            return <- create Cell()
        }
    }

    init() {
        self.account.storage.save(<- create Cell(), to: /storage/MetabolismCell)
    }
}
