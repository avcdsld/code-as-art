import "ConcreteAlphabets"

transaction {
    prepare(signer: &Account) {
        let text <- ConcreteAlphabets.newText("destruction is the beginning of creation")
        var i = 0
        while i < text.length {
            log(text[i].getType().identifier)
            i = i + 1
        }
        destroy text
    }
}
