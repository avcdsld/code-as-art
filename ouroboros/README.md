## Ouroboros

```sh
python3 -m venv ape-env
source ape-env/bin/activate

```sh
  ape accounts generate my_account
    #-> INFO:     (ape-env) Newly generated mnemonic is: apology hope tent skull slender expire identify disorder engage wood cricket pluck
    #-> SUCCESS:  (ape-env) A new account '0x71ce1224BAaE0E2d4AF92A325c7bFB73C1d462Ab' with HDPath m/44'/60'/0'/0/0 has been added with the id 'my_account'
  or
  ape accounts import my_account

  ape accounts list
    #-> Found 1 account:
    #-> 0x71ce1224BAaE0E2d4AF92A325c7bFB73C1d462Ab (alias: 'my_account')
```


```sh
  pip install eth-ape 
  ape plugins install vyper
  ape --version

  ape compile
  ape test -s
```
