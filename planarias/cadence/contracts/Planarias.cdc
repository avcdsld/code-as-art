// This smart contract does not implement the NonFungibleToken interface.
// The planarias are just that, as they are.

pub contract Planarias {
    pub var population: UInt64

    pub event Begin()
    pub event Born(name: UInt64, genes: Genes, generation: UInt256, motherName: UInt64?, fatherName: UInt64?)
    pub event In(name: UInt64, to: Address?)
    pub event Out(name: UInt64, from: Address?)
    pub event Die(name: UInt64)
    pub event End()

    pub struct Genes {
        pub let primary: UInt256
        pub let secondary: UInt256

        init(primary: UInt256, secondary: UInt256) {
            self.primary = primary
            self.secondary = secondary
        }
    }

    pub resource Planaria {
        pub let name: UInt64
        pub let genes: Genes
        pub let generation: UInt256
        pub let birthtime: UFix64
        pub let motherName: UInt64?
        pub let fatherName: UInt64?
        pub var copulatoryPouch: {UInt64: UInt256}

        init(genes: Genes, generation: UInt256, motherName: UInt64?, fatherName: UInt64?) {
            self.name = self.uuid
            self.genes = genes
            self.generation = generation
            self.birthtime = getCurrentBlock().timestamp
            self.motherName = motherName
            self.fatherName = fatherName
            self.copulatoryPouch = {}

            Planarias.population = Planarias.population + 1
            if Planarias.population == 1 {
                emit Begin()
            }

            emit Born(
                name: self.name,
                genes: self.genes,
                generation: self.generation,
                motherName: self.motherName,
                fatherName: self.fatherName
            )
        }

        pub fun reproduceAsexually(): @Planaria {
            return <- create Planaria(
                genes: self.genes,
                generation: self.generation + 1,
                motherName: self.name,
                fatherName: nil
            )
        }

        pub fun reproduceSexually(): @Planaria {
            pre {
                self.copulatoryPouch.length > 0: "no father gene"
            }
            let fatherNames = self.copulatoryPouch.keys
            let fatherName = fatherNames[Int(unsafeRandom() % UInt64(fatherNames.length))]!
            let fatherGene = self.copulatoryPouch.remove(key: fatherName)!
            let motherGene = self.meiosis()
            return <- create Planaria(
                genes: Genes(primary: fatherGene, secondary: motherGene),
                generation: self.generation + 1,
                motherName: self.name,
                fatherName: fatherName
            )
        }

        pub fun copulate(father: &Planaria) {
            let fatherGene = father.meiosis()
            self.copulatoryPouch.insert(key: father.name, fatherGene)
        }

        pub fun meiosis(): UInt256 {
            let randomChiasmaMask = fun (): UInt256 {
                var mask: UInt256 = 0
                var val: UInt256 = unsafeRandom() % UInt64(2) == 0 ? 0 : 1
                var i = 0
                while i < 256 {
                    let length = Int(unsafeRandom() % UInt64(128))
                    var j = 0
                    while j < length {
                        mask = (mask << 1) + UInt256(val)
                        j = j + 1
                        if i + j >= 256 {
                            break
                        }
                    }
                    i = i + j
                    val = (val + 1) % 2
                }
                return mask
            }
            let chiasma = randomChiasmaMask()
            let sequence = (self.genes.primary & chiasma) | (self.genes.secondary & (chiasma ^ UInt256.max))
            let mutation = UInt256(1 << Int(unsafeRandom() % UInt64(256)))
            return sequence ^ mutation
        }

        destroy() {
            emit Die(name: self.name)
            Planarias.population = Planarias.population - 1
            if Planarias.population == 0 {
                emit End()
            }
        }
    }

    pub resource Habitat {
        pub var planarias: @{UInt64: Planaria}

        init () {
            self.planarias <- {}
        }

        pub fun out(name: UInt64): @Planaria {
            let planaria <- self.planarias.remove(key: name) ?? panic("Missing Planaria")
            emit Out(name: planaria.name, from: self.owner?.address)
            return <- planaria
        }

        pub fun in(planaria: @Planaria) {
            let name: UInt64 = planaria.name
            self.planarias[name] <-! planaria
            emit In(name: name, to: self.owner?.address)
        }

        pub fun getNames(): [UInt64] {
            return self.planarias.keys
        }

        pub fun borrowPlanaria(name: UInt64): &Planaria? {
            return &self.planarias[name] as &Planaria?
        }

        destroy() {
            destroy self.planarias
        }
    }

    pub fun createHabitat(): @Habitat {
        return <- create Habitat()
    }

    pub fun generate(): @Planaria {
        let newGene = fun (): UInt256 {
            return UInt256(unsafeRandom()) + (UInt256(unsafeRandom()) << 64) + (UInt256(unsafeRandom()) << 128) + (UInt256(unsafeRandom()) << 192)
        }
        return <- create Planaria(
            genes: Genes(primary: newGene(), secondary: newGene()),
            generation: 0,
            motherName: nil,
            fatherName: nil
        )
    }

    init() {
        self.population = 0
        self.account.save(<- create Habitat(), to: /storage/PlanariasHabitat)
        self.account.link<&Planarias.Habitat>(/public/PlanariasHabitat, target: /storage/PlanariasHabitat)
    }
}
