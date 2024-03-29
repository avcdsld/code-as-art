import * as dotenv from "dotenv";

import { HardhatUserConfig, task } from "hardhat/config";
import "@nomiclabs/hardhat-etherscan";
import "@nomiclabs/hardhat-waffle";
import "@typechain/hardhat";
import "hardhat-gas-reporter";
import "solidity-coverage";

dotenv.config();

task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();
  for (const account of accounts) {
    console.log(account.address);
  }
});

const privateKey = process.env.PRIVATE_KEY || "0x0000000000000000000000000000000000000000000000000000000000000000"; // this is to avoid hardhat error

const config: HardhatUserConfig = {
  solidity: "0.8.17",
  networks: {
    localhost: {
      timeout: 50000,
    },
    hardhat: {
      forking: {
        url: "https://polygon-mainnet.infura.io/v3/7495501b681645b0b80f955d4139add9",
      },
    },
    mainnet: {
      url: "https://mainnet.infura.io/v3/9f5ace8940244ed9a769e493d783fda8",
      accounts: [privateKey],
      gas: 2100000,
      gasPrice: 16000000000,
    }
  },
  gasReporter: {
    enabled: process.env.REPORT_GAS !== undefined,
    currency: "USD",
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY,
  },
};

export default config;
