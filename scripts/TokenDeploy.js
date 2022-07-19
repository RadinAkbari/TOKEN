const hre = require("hardhat");

async function main() {

  const Token = await hre.ethers.getContractFactory("Radin");
  const token = await Token.deploy();

  await token.deployed();

  console.log("token deployed to:", token.address);
}

main()
.then(() => process.exit(0))
.catch((error) => {
  console.error(error);
  process.exit(1);
});
