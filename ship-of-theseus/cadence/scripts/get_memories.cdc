import "ShipOfTheseus"

pub fun main(): [ShipOfTheseus.Memory] {
    let theShip = &ShipOfTheseus.theShip[0] as &ShipOfTheseus.Ship
    return theShip.getMemories()
}
