import "BIP39WordList"
import "ConcreteAlphabets"
import "ConcreteAlphabetsHiragana"
import "ConcreteAlphabetsHangle"
import "ConcreteAlphabetsSpanish"
import "ConcreteAlphabetsSimplifiedChinese"
import "ConcreteAlphabetsTraditionalChinese"
import "ConcreteAlphabetsFrench"

pub contract ConcreteBlockPoetryBIP39 {

    pub event NewPoems(poems: [String])

    pub struct interface IPoetryLogic {
        pub fun generatePoems(blockID: [UInt8; 32]): [String]
        pub fun generateConcreteAlphabets(poems: [String]): @[[AnyResource]]
    }

    pub struct PoetryLogic: IPoetryLogic {
        pub fun generatePoems(blockID: [UInt8; 32]): [String] {
            var poemEn = ""
            var poemJa = ""
            var poemKo = ""
            var poemEs = ""
            var poemZhCN = ""
            var poemZhTW = ""
            var poemFr = ""
            var poemIt = ""
            var poemCs = ""
            var poemPt = ""
            var i = 0
            while i + 1 < 32 {
                let index = Int(Int32(blockID[i]!) * Int32(blockID[i + 1]!) % Int32(BIP39WordList.length))
                poemEn = poemEn.concat(i > 0 ? " " : "").concat(BIP39WordList.en[index]!)
                poemJa = poemJa.concat(i > 0 ? " " : "").concat(BIP39WordList.ja[index]!)
                poemKo = poemKo.concat(i > 0 ? " " : "").concat(BIP39WordList.ko[index]!)
                poemEs = poemEs.concat(i > 0 ? " " : "").concat(BIP39WordList.es[index]!)
                poemZhCN = poemZhCN.concat(i > 0 ? " " : "").concat(BIP39WordList.zhCN[index]!)
                poemZhTW = poemZhTW.concat(i > 0 ? " " : "").concat(BIP39WordList.zhTW[index]!)
                poemFr = poemFr.concat(i > 0 ? " " : "").concat(BIP39WordList.fr[index]!)
                poemIt = poemIt.concat(i > 0 ? " " : "").concat(BIP39WordList.it[index]!)
                poemCs = poemCs.concat(i > 0 ? " " : "").concat(BIP39WordList.cs[index]!)
                poemPt = poemPt.concat(i > 0 ? " " : "").concat(BIP39WordList.pt[index]!)
                i = i + 2
            }
            return [
                poemEn,
                poemJa,
                poemKo,
                poemEs,
                poemZhCN,
                poemZhTW,
                poemFr,
                poemIt,
                poemCs,
                poemPt
            ]
        }

        pub fun generateConcreteAlphabets(poems: [String]): @[[AnyResource]] {
            let concreteAlphabets: @[[AnyResource]] <- []
            concreteAlphabets.append(<- ConcreteAlphabets.newText(poems[0]))
            concreteAlphabets.append(<- ConcreteAlphabetsHiragana.newText(poems[1]))
            concreteAlphabets.append(<- ConcreteAlphabetsHangle.newText(poems[2]))
            concreteAlphabets.append(<- ConcreteAlphabetsSpanish.newText(poems[3]))
            concreteAlphabets.append(<- ConcreteAlphabetsSimplifiedChinese.newText(poems[4]))
            concreteAlphabets.append(<- ConcreteAlphabetsTraditionalChinese.newText(poems[5]))
            concreteAlphabets.append(<- ConcreteAlphabetsFrench.newText(poems[6]))
            concreteAlphabets.append(<- ConcreteAlphabets.newText(poems[7]))
            concreteAlphabets.append(<- ConcreteAlphabets.newText(poems[8]))
            concreteAlphabets.append(<- ConcreteAlphabets.newText(poems[9]))
            return <- concreteAlphabets
        }
    }

    pub resource interface PoetryCollectionPublic {
        pub var poems: @{UFix64: [AnyResource]}
    }

    pub resource PoetryCollection: PoetryCollectionPublic {

        pub var poems: @{UFix64: [AnyResource]}

        init() {
            self.poems <- {}
        }

        destroy() {
            destroy self.poems
        }

        pub fun writePoems(poetryLogic: {IPoetryLogic}) {
            let poems = poetryLogic.generatePoems(blockID: getCurrentBlock().id)
            self.poems[getCurrentBlock().timestamp] <-! <- poetryLogic.generateConcreteAlphabets(poems: poems)
            emit NewPoems(poems: poems)
        }
    }

    pub fun createEmptyPoetryCollection(): @PoetryCollection {
        return <- create PoetryCollection()
    }
}
