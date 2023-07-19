pub contract HonestVillageAndLiarVillage {

    pub resource Villager {
        pub let is_liar: Bool

        init(is_liar: Bool) { self.is_liar = is_liar }

        pub fun is_this_your_village(village: String): Bool {
            let answer = village == self.villege()
            return self.is_liar ? !answer : answer
        }

        priv fun villege(): String {
            return self.is_liar ? "Liar Village" : "Honest Village"
        }
    }

    pub fun born(is_liar: Bool): @Villager {
        return <- create Villager(is_liar: is_liar)
    }
}
