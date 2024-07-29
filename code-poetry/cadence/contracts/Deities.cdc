access(all) contract Deities {

    // Deity can be defined, but it cannot be instantiated.

    access(all) resource Deity {
        access(all) var name: String
        access(all) var gender: String?
        access(all) var ability: String?
        access(all) var purpose: String?

        init(name: String, gender: String?, ability: String?, purpose: String?) {
            self.name = name
            self.gender = gender
            self.ability = ability
            self.purpose = purpose
        }

        access(all) fun setName(_ name: String) {
            self.name = name
        }

        access(all) fun setGender(_ gender: String?) {
            self.gender = gender
        }

        access(all) fun setAbility(_ ability: String?) {
            self.ability = ability
        }

        access(all) fun setPurpose(_ purpose: String?) {
            self.purpose = purpose
        }
    }
}
