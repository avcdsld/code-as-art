import { expect } from "chai";
import { ethers } from "hardhat";

describe("TheNFT", function () {
  it("should mint", async function () {
    const TheNFT = await ethers.getContractFactory("TheNFT");
    const theNFT = await TheNFT.deploy();
    await theNFT.deployed();

    expect(await theNFT.tokenSupply()).to.equal(0);

    const mintTx = await theNFT.mint();
    await mintTx.wait();

    expect(await theNFT.tokenSupply()).to.equal(1);

    console.log(await theNFT.tokenURI(1));

    console.log(await theNFT.dataTextPlain(1));
    console.log(await theNFT.dataTextHtml(1));
    console.log(await theNFT.dataImageSvg(1));
  });
});
