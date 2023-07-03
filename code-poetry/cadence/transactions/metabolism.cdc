import "Metabolism"

transaction {
    prepare(signer: AuthAccount) {
        let cell <- signer.load<@Metabolism.Cell>(from: /storage/MetabolismCell)!
        let newCell <- cell.kill()
        destroy cell
        signer.save(<- newCell, to: /storage/MetabolismCell)
    }
}
