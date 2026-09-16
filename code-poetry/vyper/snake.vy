#pragma version ^0.4.0

eating: address

@deploy
def __init__():
    self.eating = self

@external
@payable
def __default__():
    selfdestruct(self.eating)
