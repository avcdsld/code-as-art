from ape import project, accounts

def main():
    deployer = accounts[0]

    snake = deployer.deploy(project.Snake)
    print(f"Snake deployed at: {snake.address}")

    ouroboros = deployer.deploy(project.Ouroboros, snake.address)
    print(f"Ouroboros deployed at: {ouroboros.address}")

    ouroboros.deploy()
    print("deploy success")
