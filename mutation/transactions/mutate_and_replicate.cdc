import Mutation from "../contracts/Mutation.cdc"

transaction {
    prepare(account: AuthAccount) {
        Mutation.mutate()
        Mutation.replicate(account: account)
    }
}
