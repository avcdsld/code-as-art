import "Planarias"

transaction {
    prepare(signer: AuthAccount) {
        if signer.borrow<&Planarias.Habitat>(from: /storage/PlanariasHabitat) == nil {
            signer.save(<- Planarias.createHabitat(), to: /storage/PlanariasHabitat)
            signer.link<&Planarias.Habitat>(/public/PlanariasHabitat, target: /storage/PlanariasHabitat)
        }
        let habitat = signer.borrow<&Planarias.Habitat>(from: /storage/PlanariasHabitat) ?? panic("Not Found")

        let planaria1 <- Planarias.generate()
        let planaria2 <- Planarias.generate()

        let fatherGene <- planaria1.meiosis()
        planaria2.copulate(gene: <- fatherGene)
        let planaria3 <- planaria2.reproduceSexually()

        habitat.in(planaria: <- planaria1)
        habitat.in(planaria: <- planaria2)
        habitat.in(planaria: <- planaria3)
    }
}
