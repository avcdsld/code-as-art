flow accounts create --key 9805b096655528f34ebfcc6f2ce7fda85106c44f98ab84b1b20469909bc7c7ae7045a659431676e98c351e7375fd943765d64d9d290e0359c7cbc941614fabcc --signer emulator-account
# -> 01cf0e2f2f715450

flow transactions send ./transactions/replicate.cdc --signer emulator-account2
