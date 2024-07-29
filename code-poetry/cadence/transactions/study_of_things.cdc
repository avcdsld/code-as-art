import "StudyOfThings"

transaction {
    prepare(signer: &Account) {
        let object <- StudyOfThings.get()
        let mind <- StudyOfThings.call()
        StudyOfThings.produce(
            object: &object as &StudyOfThings.Object,
            mind: &mind as &StudyOfThings.Mind
        )
        destroy object
        destroy mind
    }
}
