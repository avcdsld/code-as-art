import SelfReplication from "../contracts/SelfReplication.cdc"

transaction {
    prepare(account: AuthAccount) {
        SelfReplication.replicate(account: account)
    }
}
