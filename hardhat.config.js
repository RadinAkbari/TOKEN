require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.0",
  networks: {
    mumbai: {
      url: "https://rpc-mumbai.maticvigil.com",
      accounts: ["591440322a73daf2ef706c28d2d88e2f7a78bbbd69e035b1be477b7e80eec948"]
    }
  }
};
