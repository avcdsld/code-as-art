import "ConcreteBlockPoetry"

pub fun main(owner: Address) {
    let collectionRef = getAccount(owner).capabilities
                        .borrow<&ConcreteBlockPoetry.PoetryCollection{ConcreteBlockPoetry.PoetryCollectionPublic}>
                        (/public/PoetryCollectionVol1) ?? panic("Not Found")
    let poems = &collectionRef.poems as &{UFix64: [AnyResource]}
    for timestamp in poems.keys {
        log(timestamp)
        let alphabets = (&poems[timestamp] as &[AnyResource]?)!
        var i = 0
        while i < alphabets.length {
            log(alphabets[i].getType().identifier)
            i = i + 1
        }
    }
}
