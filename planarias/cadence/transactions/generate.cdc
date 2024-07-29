import "Planarias"

transaction {
    prepare(signer: auth(BorrowValue, SaveValue, StorageCapabilities, PublishCapability) &Account) {
        if signer.storage.borrow<&Planarias.Habitat>(from: /storage/PlanariasHabitat) == nil {
            signer.storage.save(<- Planarias.createHabitat(), to: /storage/PlanariasHabitat)
            let cap = signer.capabilities.storage.issue<&Planarias.Habitat>(/storage/PlanariasHabitat)
            signer.capabilities.publish(cap, at: /public/PlanariasHabitat)
        }
        let habitat = signer.storage.borrow<&Planarias.Habitat>(from: /storage/PlanariasHabitat) ?? panic("Not Found")
        var i = 0
        while i < 100 {
            habitat.enter(planaria: <- Planarias.generate())
            i = i + 1
        }
    }
}
