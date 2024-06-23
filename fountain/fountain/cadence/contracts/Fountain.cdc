access(all) contract Fountain {

  access(all) resource Water {}

  access(all) resource Basin {
    access(all) var pool: @[Water]
    access(all) var next: @Basin?
    init(_ next: @Basin?) { self.pool <- []; self.next <- next }

    access(all) fun drop(_ water: @Water) {
      self.pool.append(<- water)
      if (self.pool.length > 3) {
        let next = &self.next as &Basin?
        if (next != nil) {
          next!.drop(<- self.pool.removeFirst())
        } else {
          destroy self.pool.removeFirst()
        }
      }
    }

    destroy() {
      destroy self.pool
      destroy self.next
    }
  }

  access(all) let basin: @[Basin]

  init() { self.basin <- [<- create Basin(nil)] }

  access(all) fun construct() {
    self.basin.append(<- create Basin(<- self.basin.removeFirst()))
  }

  access(all) fun reconstruct() {
    destroy <- self.basin.removeFirst()
    self.basin.append(<- create Basin(nil))
  }

  access(all) fun spout() {
    self.basin[0].drop(<- create Water())
  }
}
