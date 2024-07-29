import "EffectiveLifeTime"

transaction {
    prepare(signer: &Account) {
        EffectiveLifeTime.beat()
    }
}
