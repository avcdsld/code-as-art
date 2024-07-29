# flow-c1 emulator

flow-c1 depoloy

flow-c1 accounts create --key 9805b096655528f34ebfcc6f2ce7fda85106c44f98ab84b1b20469909bc7c7ae7045a659431676e98c351e7375fd943765d64d9d290e0359c7cbc941614fabcc --signer emulator-account
# -> 179b6b1cb6755e31

flow-c1 transactions send ./transactions/replicate.cdc --signer emulator-account2
