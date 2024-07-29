import "Planarias"

transaction {
    prepare(signer: auth(BorrowValue, SaveValue, StorageCapabilities, PublishCapability) &Account) {
        if signer.storage.borrow<&Planarias.Habitat>(from: /storage/PlanariasHabitat) == nil {
            signer.storage.save(<- Planarias.createHabitat(), to: /storage/PlanariasHabitat)
            let cap = signer.capabilities.storage.issue<&Planarias.Habitat>(/storage/PlanariasHabitat)
            signer.capabilities.publish(cap, at: /public/PlanariasHabitat)
        }
        let habitat = signer.storage.borrow<&Planarias.Habitat>(from: /storage/PlanariasHabitat) ?? panic("Not Found")

        let planaria1 <- Planarias.generate()
        let planaria2 <- Planarias.generate()

        planaria2.copulate(father: &planaria1 as &Planarias.Planaria)
        let planaria3 <- planaria2.reproduceSexually()

        habitat.enter(planaria: <- planaria1)
        habitat.enter(planaria: <- planaria2)
        habitat.enter(planaria: <- planaria3)
    }
}
