import "MnemonicPoetry"

access(all) fun main(addr: Address): MnemonicPoetry.Mnemonic? {
    let collectionRef = getAccount(addr).capabilities
                        .borrow<&MnemonicPoetry.PoetryCollection>
                        (/public/MnemonicPoetryCollection) ?? panic("Not Found")
    // let collectionRef = getAccount(addr).getCapability<&MnemonicPoetry.PoetryCollection{MnemonicPoetry.PoetryCollectionPublic}>
    //                     (/public/MnemonicPoetryCollection)
    //                     .borrow() ?? panic("Not Found")
    let poems = collectionRef.mnemonics
    if poems.length == 0 {
        return nil
    }
    return poems[poems.length - 1]
}
