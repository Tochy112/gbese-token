require("dotenv").config();
const main = async () => {
  const { ethers } = require("hardhat");
  //get txn signer
  const [deployer] = await ethers.getSigners();

  //get address of signer
  const accAddress = await deployer.getAddress();
  console.log("Deployer account Address:", accAddress);

  // get contract factory and deploy
  const contractFactory = await ethers.getContractFactory("GbeseToken");
  const deployedFactory = await contractFactory.deploy(
    process.env.TOKEN_NAME,
    process.env.TOKEN_SYMBOL,
    process.env.TOKEN_DESCRIPTION,
    process.env.TOKEN_IMAGE_URL
  );

  console.log(
    "Get deployed smart contract address:",
    await deployedFactory.getAddress()
  );
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
