import Mutation from "../contracts/Mutation.cdc"

transaction {
    prepare(account: auth(AddContract) &Account) {
        Mutation.mutate()
        Mutation.replicate(account: account)
    }
}
