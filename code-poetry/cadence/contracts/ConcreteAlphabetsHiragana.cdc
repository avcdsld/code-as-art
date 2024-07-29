// You can create concrete poems with these alphabet resources.

access(all) contract ConcreteAlphabetsHiragana {
    access(all) resource U3041{} // ぁ
    access(all) resource U3042{} // あ
    access(all) resource U3043{} // ぃ
    access(all) resource U3044{} // い
    access(all) resource U3045{} // ぅ
    access(all) resource U3046{} // う
    access(all) resource U3047{} // ぇ
    access(all) resource U3048{} // え
    access(all) resource U3049{} // ぉ
    access(all) resource U304A{} // お
    access(all) resource U304B{} // か
    access(all) resource U304C{} // が
    access(all) resource U304D{} // き
    access(all) resource U304E{} // ぎ
    access(all) resource U304F{} // く
    access(all) resource U3050{} // ぐ
    access(all) resource U3051{} // け
    access(all) resource U3052{} // げ
    access(all) resource U3053{} // こ
    access(all) resource U3054{} // ご
    access(all) resource U3055{} // さ
    access(all) resource U3056{} // ざ
    access(all) resource U3057{} // し
    access(all) resource U3058{} // じ
    access(all) resource U3059{} // す
    access(all) resource U305A{} // ず
    access(all) resource U305B{} // せ
    access(all) resource U305C{} // ぜ
    access(all) resource U305D{} // そ
    access(all) resource U305E{} // ぞ
    access(all) resource U305F{} // た
    access(all) resource U3060{} // だ
    access(all) resource U3061{} // ち
    access(all) resource U3062{} // ぢ
    access(all) resource U3063{} // っ
    access(all) resource U3064{} // つ
    access(all) resource U3065{} // づ
    access(all) resource U3066{} // て
    access(all) resource U3067{} // で
    access(all) resource U3068{} // と
    access(all) resource U3069{} // ど
    access(all) resource U306A{} // な
    access(all) resource U306B{} // に
    access(all) resource U306C{} // ぬ
    access(all) resource U306D{} // ね
    access(all) resource U306E{} // の
    access(all) resource U306F{} // は
    access(all) resource U3070{} // ば
    access(all) resource U3071{} // ぱ
    access(all) resource U3072{} // ひ
    access(all) resource U3073{} // び
    access(all) resource U3074{} // ぴ
    access(all) resource U3075{} // ふ
    access(all) resource U3076{} // ぶ
    access(all) resource U3077{} // ぷ
    access(all) resource U3078{} // へ
    access(all) resource U3079{} // べ
    access(all) resource U307A{} // ぺ
    access(all) resource U307B{} // ほ
    access(all) resource U307C{} // ぼ
    access(all) resource U307D{} // ぽ
    access(all) resource U307E{} // ま
    access(all) resource U307F{} // み
    access(all) resource U3080{} // む
    access(all) resource U3081{} // め
    access(all) resource U3082{} // も
    access(all) resource U3083{} // ゃ
    access(all) resource U3084{} // や
    access(all) resource U3085{} // ゅ
    access(all) resource U3086{} // ゆ
    access(all) resource U3087{} // ょ
    access(all) resource U3088{} // よ
    access(all) resource U3089{} // ら
    access(all) resource U308A{} // り
    access(all) resource U308B{} // る
    access(all) resource U308C{} // れ
    access(all) resource U308D{} // ろ
    access(all) resource U308E{} // ゎ
    access(all) resource U308F{} // わ
    access(all) resource U3090{} // ゐ
    access(all) resource U3091{} // ゑ
    access(all) resource U3092{} // を
    access(all) resource U3093{} // ん
    access(all) resource U3094{} // ゔ
    access(all) resource U3000{} // 　 (Idepgraphic Space)

    access(all) fun newLetter(_ ch: Character): @AnyResource {
        switch ch {
            case "ぁ": return <- create U3041()
            case "あ": return <- create U3042()
            case "ぃ": return <- create U3043()
            case "い": return <- create U3044()
            case "ぅ": return <- create U3045()
            case "う": return <- create U3046()
            case "ぇ": return <- create U3047()
            case "え": return <- create U3048()
            case "ぉ": return <- create U3049()
            case "お": return <- create U304A()
            case "か": return <- create U304B()
            case "が": return <- create U304C()
            case "き": return <- create U304D()
            case "ぎ": return <- create U304E()
            case "く": return <- create U304F()
            case "ぐ": return <- create U3050()
            case "け": return <- create U3051()
            case "げ": return <- create U3052()
            case "こ": return <- create U3053()
            case "ご": return <- create U3054()
            case "さ": return <- create U3055()
            case "ざ": return <- create U3056()
            case "し": return <- create U3057()
            case "じ": return <- create U3058()
            case "す": return <- create U3059()
            case "ず": return <- create U305A()
            case "せ": return <- create U305B()
            case "ぜ": return <- create U305C()
            case "そ": return <- create U305D()
            case "ぞ": return <- create U305E()
            case "た": return <- create U305F()
            case "だ": return <- create U3060()
            case "ち": return <- create U3061()
            case "ぢ": return <- create U3062()
            case "っ": return <- create U3063()
            case "つ": return <- create U3064()
            case "づ": return <- create U3065()
            case "て": return <- create U3066()
            case "で": return <- create U3067()
            case "と": return <- create U3068()
            case "ど": return <- create U3069()
            case "な": return <- create U306A()
            case "に": return <- create U306B()
            case "ぬ": return <- create U306C()
            case "ね": return <- create U306D()
            case "の": return <- create U306E()
            case "は": return <- create U306F()
            case "ば": return <- create U3070()
            case "ぱ": return <- create U3071()
            case "ひ": return <- create U3072()
            case "び": return <- create U3073()
            case "ぴ": return <- create U3074()
            case "ふ": return <- create U3075()
            case "ぶ": return <- create U3076()
            case "ぷ": return <- create U3077()
            case "へ": return <- create U3078()
            case "べ": return <- create U3079()
            case "ぺ": return <- create U307A()
            case "ほ": return <- create U307B()
            case "ぼ": return <- create U307C()
            case "ぽ": return <- create U307D()
            case "ま": return <- create U307E()
            case "み": return <- create U307F()
            case "む": return <- create U3080()
            case "め": return <- create U3081()
            case "も": return <- create U3082()
            case "ゃ": return <- create U3083()
            case "や": return <- create U3084()
            case "ゅ": return <- create U3085()
            case "ゆ": return <- create U3086()
            case "ょ": return <- create U3087()
            case "よ": return <- create U3088()
            case "ら": return <- create U3089()
            case "り": return <- create U308A()
            case "る": return <- create U308B()
            case "れ": return <- create U308C()
            case "ろ": return <- create U308D()
            case "ゎ": return <- create U308E()
            case "わ": return <- create U308F()
            case "ゐ": return <- create U3090()
            case "ゑ": return <- create U3091()
            case "を": return <- create U3092()
            case "ん": return <- create U3093()
            case "ゔ": return <- create U3094()
            default: return <- create U3000()
        }
    }

    access(all) fun newText(_ str: String): @[AnyResource] {
        var res: @[AnyResource] <- []
        for ch in str {
            res.append(<- ConcreteAlphabetsHiragana.newLetter(ch))
        }
        return <- res
    }

    access(all) fun toCharacter(_ letter: &AnyResource): Character {
        switch letter.getType() {
            case Type<@U3041>(): return "ぁ"
            case Type<@U3042>(): return "あ"
            case Type<@U3043>(): return "ぃ"
            case Type<@U3044>(): return "い"
            case Type<@U3045>(): return "ぅ"
            case Type<@U3046>(): return "う"
            case Type<@U3047>(): return "ぇ"
            case Type<@U3048>(): return "え"
            case Type<@U3049>(): return "ぉ"
            case Type<@U304A>(): return "お"
            case Type<@U304B>(): return "か"
            case Type<@U304C>(): return "が"
            case Type<@U304D>(): return "き"
            case Type<@U304E>(): return "ぎ"
            case Type<@U304F>(): return "く"
            case Type<@U3050>(): return "ぐ"
            case Type<@U3051>(): return "け"
            case Type<@U3052>(): return "げ"
            case Type<@U3053>(): return "こ"
            case Type<@U3054>(): return "ご"
            case Type<@U3055>(): return "さ"
            case Type<@U3056>(): return "ざ"
            case Type<@U3057>(): return "し"
            case Type<@U3058>(): return "じ"
            case Type<@U3059>(): return "す"
            case Type<@U305A>(): return "ず"
            case Type<@U305B>(): return "せ"
            case Type<@U305C>(): return "ぜ"
            case Type<@U305D>(): return "そ"
            case Type<@U305E>(): return "ぞ"
            case Type<@U305F>(): return "た"
            case Type<@U3060>(): return "だ"
            case Type<@U3061>(): return "ち"
            case Type<@U3062>(): return "ぢ"
            case Type<@U3063>(): return "っ"
            case Type<@U3064>(): return "つ"
            case Type<@U3065>(): return "づ"
            case Type<@U3066>(): return "て"
            case Type<@U3067>(): return "で"
            case Type<@U3068>(): return "と"
            case Type<@U3069>(): return "ど"
            case Type<@U306A>(): return "な"
            case Type<@U306B>(): return "に"
            case Type<@U306C>(): return "ぬ"
            case Type<@U306D>(): return "ね"
            case Type<@U306E>(): return "の"
            case Type<@U306F>(): return "は"
            case Type<@U3070>(): return "ば"
            case Type<@U3071>(): return "ぱ"
            case Type<@U3072>(): return "ひ"
            case Type<@U3073>(): return "び"
            case Type<@U3074>(): return "ぴ"
            case Type<@U3075>(): return "ふ"
            case Type<@U3076>(): return "ぶ"
            case Type<@U3077>(): return "ぷ"
            case Type<@U3078>(): return "へ"
            case Type<@U3079>(): return "べ"
            case Type<@U307A>(): return "ぺ"
            case Type<@U307B>(): return "ほ"
            case Type<@U307C>(): return "ぼ"
            case Type<@U307D>(): return "ぽ"
            case Type<@U307E>(): return "ま"
            case Type<@U307F>(): return "み"
            case Type<@U3080>(): return "む"
            case Type<@U3081>(): return "め"
            case Type<@U3082>(): return "も"
            case Type<@U3083>(): return "ゃ"
            case Type<@U3084>(): return "や"
            case Type<@U3085>(): return "ゅ"
            case Type<@U3086>(): return "ゆ"
            case Type<@U3087>(): return "ょ"
            case Type<@U3088>(): return "よ"
            case Type<@U3089>(): return "ら"
            case Type<@U308A>(): return "り"
            case Type<@U308B>(): return "る"
            case Type<@U308C>(): return "れ"
            case Type<@U308D>(): return "ろ"
            case Type<@U308E>(): return "ゎ"
            case Type<@U308F>(): return "わ"
            case Type<@U3090>(): return "ゐ"
            case Type<@U3091>(): return "ゑ"
            case Type<@U3092>(): return "を"
            case Type<@U3093>(): return "ん"
            case Type<@U3094>(): return "ゔ"
            case Type<@U3000>(): return "　"
            default: return "?"
        }
    }

    access(all) fun toString(_ text: &[AnyResource]): String {
        var res: String = ""
        var i = 0
        while i < text.length {
            let letter = text[i]
            res = res.concat(ConcreteAlphabetsHiragana.toCharacter(letter).toString())
            i = i + 1
        }
        return res
    }
}
