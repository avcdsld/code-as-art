import "MnemonicPoetry"

access(all) fun main(addr: Address): MnemonicPoetry.Mnemonic? {
    let collectionRef = getAccount(addr)
                        .capabilities.get<&MnemonicPoetry.PoetryCollection>(/public/MnemonicPoetryCollection)
                        .borrow() ?? panic("Not Found")
    let mnemonics = collectionRef.mnemonics
    if mnemonics.length == 0 {
        return nil
    }
    return collectionRef.getMnemonic(index: mnemonics.length - 1)
}
