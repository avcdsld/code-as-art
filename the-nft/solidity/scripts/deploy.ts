import { ethers } from "hardhat";

async function main() {
  const TheNFT = await ethers.getContractFactory("TheNFT");
  const theNFT = await TheNFT.deploy();
  await theNFT.deployed();
  console.log("TheNFT deployed to:", theNFT.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
