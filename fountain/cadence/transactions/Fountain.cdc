import "Fountain"

transaction {
  prepare(account: &Account) {
    var i = 0
    while i < 3 {
      Fountain.construct()
      i = i + 1
    }
    i = 0
    while i < 10 {
      Fountain.spout()
      i = i + 1
    }
  }
}
