import "UndefinedCode"

transaction {
    prepare(signer: auth(SaveValue, LoadValue, BorrowValue) &Account) {
        let code <- UndefinedCode.find()
        let storagePath = StoragePath(identifier: "UndefinedCode".concat(code.point.toString()))!
        if signer.storage.borrow<&UndefinedCode.Code>(from: storagePath) == nil {
            signer.storage.save(<- code, to: storagePath)
        } else {
            let specialStoragePath = StoragePath(identifier: "UndefinedCode".concat(code.point.toString()).concat(getCurrentBlock().timestamp.toString()))!
            signer.storage.save(<- code, to: specialStoragePath)
        }
    }
}
