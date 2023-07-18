module arda::deity {

    use sui::object::UID;
    use std::string::String;

    /// Deity can be defined, but it cannot be instantiated.
    struct Deity has key, store {
        id: UID,
        name: String,
        gender: String,
        ability: String,
        purpose: String,
    }
}
