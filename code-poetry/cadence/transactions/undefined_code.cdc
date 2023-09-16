import "UndefinedCode"

transaction {
    prepare(signer: AuthAccount) {
        let code <- UndefinedCode.find()
        let storagePath = StoragePath(identifier: "UndefinedCode".concat(code.point.toString()))!
        if signer.borrow<&UndefinedCode.Code>(from: storagePath) == nil {
            signer.save(<- code, to: storagePath)
        } else {
            let specialStoragePath = StoragePath(identifier: "UndefinedCode".concat(code.point.toString()).concat(getCurrentBlock().timestamp.toString()))!
            signer.save(<- code, to: specialStoragePath)
        }
    }
}
