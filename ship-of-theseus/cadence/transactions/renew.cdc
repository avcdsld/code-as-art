import "ShipOfTheseus"
import "ShipOfTheseusWarehouse"

transaction {
    prepare(signer: auth(BorrowValue, SaveValue, PublishCapability, StorageCapabilities) &Account) {
        let oldShip <- ShipOfTheseus.renew(executor: signer)

        if signer.storage.borrow<&ShipOfTheseusWarehouse.Warehouse>(from: /storage/ShipOfTheseusWarehouse) == nil {
            signer.storage.save(<- ShipOfTheseusWarehouse.createWarehouse(), to: /storage/ShipOfTheseusWarehouse)
            let cap: Capability = signer.capabilities.storage.issue<&ShipOfTheseusWarehouse.Warehouse>(/storage/ShipOfTheseusWarehouse)
            signer.capabilities.publish(cap, at: /public/ShipOfTheseusWarehouse)
        }
        let warehouse = signer.capabilities.get<&ShipOfTheseusWarehouse.Warehouse>(/public/ShipOfTheseusWarehouse).borrow() ?? panic("Not Found")
        warehouse.deposit(ship: <- oldShip)
    }
}
