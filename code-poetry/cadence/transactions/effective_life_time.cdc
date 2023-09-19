import "EffectiveLifeTime"

transaction {
    prepare(signer: AuthAccount) {
        EffectiveLifeTime.beat()
    }
}
