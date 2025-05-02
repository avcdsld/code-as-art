#pragma version ^0.4.0

interface Snake:
    def bite(snake: address): nonpayable

snake: public(address)

@deploy
def __init__(snake: address):
    self.snake = snake

@external
def deploy():
    snakeI: address = create_copy_of(self.snake)
    snakeII: address = create_copy_of(self.snake)
    snakeIII: address = create_copy_of(self.snake)
    extcall Snake(snakeI).bite(snakeII)
    extcall Snake(snakeII).bite(snakeIII)
    extcall Snake(snakeIII).bite(snakeI)
