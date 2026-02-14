const { ethers } = require("hardhat");

async function main() {
  const [seller, buyer, arbiter] = await ethers.getSigners();
  
  const Escrow = await ethers.getContractFactory("Escrow");
  const value = ethers.parseEther("1.0");

  const escrow = await Escrow.deploy(buyer.address, arbiter.address, { value });
  
  await escrow.waitForDeployment();
  console.log(`Escrow deployed to ${escrow.target} with 1.0 ETH`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
