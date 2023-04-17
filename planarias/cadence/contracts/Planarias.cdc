// This smart contract does not implement the NonFungibleToken interface.
// The planarias are just that, as they are.

pub contract Planarias {
    pub var population: UInt64

    pub event Begin()
    // pub event Born(name: UInt64, genes: Genes) // TODO:
    pub event In(name: UInt64, to: Address?)
    pub event Out(name: UInt64, from: Address?)
    pub event Die(name: UInt64)

    pub resource Gene {
        pub let sequence: UInt256
        pub let parentName: UInt64?

        init(sequence: UInt256, parentName: UInt64?) {
            self.sequence = sequence
            self.parentName = parentName
        }

        // pub fun duplicate(): @Gene {

        // }
    }

    // pub struct Genes {
    //     pub let primary: @Gene
    //     pub let secondary: @Gene

    //     init(primary: @Gene, secondary: @Gene) {
    //         self.primary <- primary
    //         self.secondary <- secondary
    //     }
    // }

    pub resource Planaria {
        pub let name: UInt64
        pub let genes: @[Gene] // @[Gene; 2]
        pub let generation: UInt256
        pub let birthtime: UFix64
        pub var copulatoryPouch: @[Gene]

        init(genes: @[Gene], generation: UInt256) {
            self.name = self.uuid
            self.genes <- genes
            self.generation = generation
            self.birthtime = getCurrentBlock().timestamp
            self.copulatoryPouch <- []
            Planarias.population = Planarias.population + 1
            // emit Born(name: self.name, genes: <- self.genes) // TODO:
        }

        pub fun reproduceAsexually(): @Planaria {
            let gene1Ref = (&self.genes[0] as! &Gene?)!
            let gene2Ref = (&self.genes[1] as! &Gene?)!
            let genes <- [
                <- create Gene(sequence: gene1Ref.sequence, parentName: self.name),
                <- create Gene(sequence: gene2Ref.sequence, parentName: self.name)
            ]
            return <- create Planaria(genes: <- genes, generation: self.generation + 1)
        }

        pub fun reproduceSexually(): @Planaria {
            pre {
                self.copulatoryPouch.length > 0: "no father gene"
            }
            let fatherGeneIndex = Int(unsafeRandom() % UInt64(self.copulatoryPouch.length))
            let fatherGene <- self.copulatoryPouch.remove(at: fatherGeneIndex)
            let motherGene <- self.meiosis()
            return <- create Planaria(genes: <- [<- fatherGene, <- motherGene], generation: self.generation + 1)
        }

        pub fun copulate(gene: @Gene) {
            self.copulatoryPouch.append(<- gene)
        }

        pub fun meiosis(): @Gene {
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
            let gene1Ref = (&self.genes[0] as! &Gene?)!
            let gene2Ref = (&self.genes[1] as! &Gene?)!
            let sequence = (gene1Ref.sequence & chiasma) | (gene2Ref.sequence & (chiasma ^ UInt256.max))
            let mutation = UInt256(1 << Int(unsafeRandom() % UInt64(256)))
            return <- create Gene(sequence: sequence ^ mutation, parentName: self.name)
        }

        destroy() {
            destroy self.genes
            destroy self.copulatoryPouch
            emit Die(name: self.name)
            Planarias.population = Planarias.population - 1
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
        let newGene = fun (): @Gene {
            return <- create Gene(
                sequence: UInt256(unsafeRandom()) + (UInt256(unsafeRandom()) << 64) + (UInt256(unsafeRandom()) << 128) + (UInt256(unsafeRandom()) << 192),
                parentName: nil
            )
        }
        return <- create Planaria(genes: <- [<- newGene(), <- newGene()], generation: 0)
    }

    init() {
        emit Begin()
        self.population = 0
        self.account.save(<- create Habitat(), to: /storage/PlanariasHabitat)
        self.account.link<&Planarias.Habitat>(/public/PlanariasHabitat, target: /storage/PlanariasHabitat)
    }
}
