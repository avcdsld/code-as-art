import "ShipOfTheseus"
import "ShipOfTheseusWarehouse"

transaction {
    prepare(signer: AuthAccount) {
        let oldShip <- ShipOfTheseus.renew(executor: &signer as &AuthAccount)

        if signer.borrow<&ShipOfTheseusWarehouse.Warehouse>(from: /storage/ShipOfTheseusWarehouse) == nil {
            signer.save(<- ShipOfTheseusWarehouse.createWarehouse(), to: /storage/ShipOfTheseusWarehouse)
            signer.link<&ShipOfTheseusWarehouse.Warehouse{ShipOfTheseusWarehouse.WarehousePublic}>(/public/ShipOfTheseusWarehouse, target: /storage/ShipOfTheseusWarehouse)
        }
        let warehouse = signer.getCapability(/public/ShipOfTheseusWarehouse).borrow<&{ShipOfTheseusWarehouse.WarehousePublic}>() ?? panic("Not Found")
        warehouse.deposit(ship: <- oldShip)
    }
}
