from ape import project, accounts

def test_ouroboros_deployment():
    deployer = accounts.test_accounts[0]

    snake = deployer.deploy(project.snake)
    print(f"Snake deployed at: {snake.address}")

    ouroboros = deployer.deploy(project.ouroboros, snake.address)
    print(f"Ouroboros deployed at: {ouroboros.address}")

    assert ouroboros.snake() == snake.address
    print("deploy success")
