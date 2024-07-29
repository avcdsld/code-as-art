import "ConcreteBlockPoetry"

access(all) fun main(owner: Address) {
    let collectionRef = getAccount(owner).capabilities
                        .borrow<&ConcreteBlockPoetry.PoetryCollection>
                        (/public/PoetryCollectionVol1) ?? panic("Not Found")
    let poems = collectionRef.poems
    for timestamp in poems.keys {
        log(timestamp)
        let alphabets = poems[timestamp]!
        var i = 0
        while i < alphabets.length {
            log(alphabets[i].getType().identifier)
            i = i + 1
        }
    }
}
