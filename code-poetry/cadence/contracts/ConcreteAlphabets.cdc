// You can create concrete poems with these alphabet resources.

pub contract ConcreteAlphabets {
    pub resource A {}
    pub resource B {}
    pub resource C {}
    pub resource D {}
    pub resource E {}
    pub resource F {}
    pub resource G {}
    pub resource H {}
    pub resource I {}
    pub resource J {}
    pub resource K {}
    pub resource L {}
    pub resource M {}
    pub resource N {}
    pub resource O {}
    pub resource P {}
    pub resource Q {}
    pub resource R {}
    pub resource S {}
    pub resource T {}
    pub resource U {}
    pub resource V {}
    pub resource W {}
    pub resource X {}
    pub resource Y {}
    pub resource Z {}
    pub resource _ {}

    pub fun newLetter(_ c: Character): @AnyResource {
        switch c.toString().toLower() {
            case "a": return <- create A()
            case "b": return <- create B()
            case "c": return <- create C()
            case "d": return <- create D()
            case "e": return <- create E()
            case "f": return <- create F()
            case "g": return <- create G()
            case "h": return <- create H()
            case "i": return <- create I()
            case "j": return <- create J()
            case "k": return <- create K()
            case "l": return <- create L()
            case "m": return <- create M()
            case "n": return <- create N()
            case "o": return <- create O()
            case "p": return <- create P()
            case "q": return <- create Q()
            case "r": return <- create R()
            case "s": return <- create S()
            case "t": return <- create T()
            case "u": return <- create U()
            case "v": return <- create V()
            case "w": return <- create W()
            case "x": return <- create X()
            case "y": return <- create Y()
            case "z": return <- create Z()
            default: return <- create _()
        }
    }

    pub fun newText(_ str: String): @[AnyResource] {
        var res: @[AnyResource] <- []
        for c in str {
            res.append(<- ConcreteAlphabets.newLetter(c))
        }
        return <- res
    }
}
