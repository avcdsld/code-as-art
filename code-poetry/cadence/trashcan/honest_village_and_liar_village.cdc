import "HonestVillageAndLiarVillage"

transaction {
    prepare(signer: AuthAccount) {
        let liar <- HonestVillageAndLiarVillage.born(is_liar: true)
        let honest <- HonestVillageAndLiarVillage.born(is_liar: false)

        log(liar.is_this_your_village(village: "Liar Village"))
        log(liar.is_this_your_village(village: "Honest Village"))
        log(honest.is_this_your_village(village: "Liar Village"))
        log(honest.is_this_your_village(village: "Honest Village"))

        signer.save(<- liar, to: /storage/LiarVillager)
        signer.save(<- honest, to: /storage/LiarHonest)
    }
}
