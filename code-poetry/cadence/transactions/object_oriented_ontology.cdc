import "ObjectOrientedOntology"

transaction {
    prepare(account: auth(SaveValue, Capabilities) &Account) {
        let object <- ObjectOrientedOntology.createObject()

        let cause1 <- ObjectOrientedOntology.createObject()
        let cause2 <- ObjectOrientedOntology.createObject()
        object.causes.append(<- cause1)
        object.causes.append(<- cause2)

        let effectedObject1 <- ObjectOrientedOntology.createObject()
        let effectedObject2 <- ObjectOrientedOntology.createObject()
        account.storage.save(<- effectedObject1, to: /storage/ObjectOrientedOntologyEffectedObject1)
        account.storage.save(<- effectedObject2, to: /storage/ObjectOrientedOntologyEffectedObject2)

        let effect1 = account.capabilities.storage.issue<&ObjectOrientedOntology.Object>(
            /storage/ObjectOrientedOntologyEffectedObject1
        )
        let effect2 = account.capabilities.storage.issue<&ObjectOrientedOntology.Object>(
            /storage/ObjectOrientedOntologyEffectedObject2
        )
        object.effects.append(effect1!)
        object.effects.append(effect2!)

        log(object.undermine())
        log(object.overmine())
        log(&object as &ObjectOrientedOntology.Object)

        account.storage.save(<- object, to: /storage/ObjectOrientedOntologyObject)
    }
}
