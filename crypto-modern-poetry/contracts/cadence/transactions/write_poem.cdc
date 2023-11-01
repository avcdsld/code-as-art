import "MnemonicPoetry"

transaction(words: String, poem: String) {
    prepare(signer: AuthAccount) {
        if signer.borrow<&MnemonicPoetry.PoetryCollection>(from: /storage/MnemonicPoetryCollection) == nil {
            signer.save(<- MnemonicPoetry.createEmptyPoetryCollection(), to:  /storage/MnemonicPoetryCollection)
            let cap = signer.capabilities.storage.issue<&MnemonicPoetry.PoetryCollection{MnemonicPoetry.PoetryCollectionPublic}>(/storage/MnemonicPoetryCollection)
            signer.capabilities.publish(cap, at: /public/MnemonicPoetryCollection)
        }
        let collectionRef = signer.borrow<&MnemonicPoetry.PoetryCollection>(from: /storage/MnemonicPoetryCollection)!
        let mnemonics = collectionRef.mnemonics
        if mnemonics.length == 0 {
            panic("Not found")
        }

        var i = mnemonics.length - 1
        while i >= 0 {
            let mnemonic = mnemonics[i]
            var w = ""
            var j = 0
            while j < mnemonic.words.length {
                if j > 0 {
                    w = w.concat(" ")
                }
                w = w.concat(mnemonic.words[j])
                j = j + 1
            }
            if w == words {
                collectionRef.writePoem(mnemonic: mnemonic, poem: poem)
                break
            }
            i = i - 1
        }
    }
}
