import SelfReplication from "../contracts/SelfReplication.cdc"

transaction {
    prepare(account: auth(AddContract) &Account) {
        SelfReplication.replicate(account: account)
    }
}
