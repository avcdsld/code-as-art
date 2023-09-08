# Setup

```
$ python3 --version
-> Python 3.9.6

$ curl -fsSL "https://aptos.dev/scripts/install_cli.py" | python3

$ aptos init --network devnet
Account cd7cb42aedda73e3874080609c79db8b36946f583873e0a90f3502f976d500de doesn't exist, creating it and funding it with 100000000 Octas
Account cd7cb42aedda73e3874080609c79db8b36946f583873e0a90f3502f976d500de funded successfully

$ aptos move init --name hello

$ aptos move compile --named-addresses addr=cd7cb42aedda73e3874080609c79db8b36946f583873e0a90f3502f976d500de
Compiling, may take a little while to download git dependencies...
UPDATING GIT DEPENDENCY https://github.com/aptos-labs/aptos-core.git
INCLUDING DEPENDENCY AptosFramework
INCLUDING DEPENDENCY AptosStdlib
INCLUDING DEPENDENCY MoveStdlib
BUILDING hello
{
  "Result": [
    "cd7cb42aedda73e3874080609c79db8b36946f583873e0a90f3502f976d500de::my_module"
  ]
}

$ aptos move run-script --compiled-script-path build/hello/bytecode_scripts/main.mv --args address:b078d693856a65401d492f99ca0d6a29a0c5c0e371bc2521570a86e40d95f823 --args u64:1
bytecode_scripts/main.mv --args address:b078d693856a65401d492f99ca0d6a29a0c5c0e371bc2521570a86e40d95f823 --args u64:1
{
  "Error": "Simulation failed with status: Transaction Executed and Committed with Error LINKER_ERROR"
}

$ aptos move run-script --compiled-script-path build/hello/bytecode_scripts/main.mv --args cd7cb42aedda73e3874080609c79db8b36946f583873e0a90f3502f976d500de

```
