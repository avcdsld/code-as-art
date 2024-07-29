import "Atelier"

access(all) fun main(from: Int, upTo: Int): [Atelier.Record] {
    return Atelier.getRecords(from: from, upTo: upTo)
}
