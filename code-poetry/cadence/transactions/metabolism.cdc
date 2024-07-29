import "Metabolism"

transaction {
    prepare(signer: auth(SaveValue, LoadValue) &Account) {
        let cell <- signer.storage.load<@Metabolism.Cell>(from: /storage/MetabolismCell)!
        let newCell <- cell.kill()
        destroy cell
        signer.storage.save(<- newCell, to: /storage/MetabolismCell)
    }
}
