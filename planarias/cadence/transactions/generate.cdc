import "Planarias"

transaction {
    prepare(signer: AuthAccount) {
        if signer.borrow<&Planarias.Habitat>(from: /storage/PlanariasHabitat) == nil {
            signer.save(<- Planarias.createHabitat(), to: /storage/PlanariasHabitat)
            signer.link<&Planarias.Habitat>(/public/PlanariasHabitat, target: /storage/PlanariasHabitat)
        }
        let habitat = signer.borrow<&Planarias.Habitat>(from: /storage/PlanariasHabitat) ?? panic("Not Found")
        habitat.in(planaria: <- Planarias.generate())
    }
}
