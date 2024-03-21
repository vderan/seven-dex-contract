require('@nomicfoundation/hardhat-toolbox')
require('@openzeppelin/hardhat-upgrades')
require('hardhat-contract-sizer')
require('dotenv').config()

/**
 * @dev Get the gas provider - deployer
 */
const PRIVATE_KEY = process.env.PRIVATE_KEY

/**
 * @dev Get explorer API keys.
 */
const POLYGONSCAN_API_KEY = process.env.POLYGONSCAN_API_KEY

/**
 * @dev Get the mainnet RPC urls.
 */
const POLYGON_RPC_URL = process.env.POLYGON_RPC_URL

/**
 * @dev Get the testnet RPC urls.
 */
const MUMBAI_RPC_URL = process.env.MUMBAI_RPC_URL

/**
 * @dev Export the configuration.
 */
module.exports = {
  etherscan: {
    apiKey: POLYGONSCAN_API_KEY,
  },

  solidity: {
    compilers: [
      {
        version: '0.5.16',
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          },
        },
      },

      {
        version: '0.6.6',
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          },
        },
      },
    ],
  },

  networks: {
    polygon: {
      url: POLYGON_RPC_URL,
      chainId: 137,
      accounts: [PRIVATE_KEY],
    },

    mumbai: {
      url: MUMBAI_RPC_URL,
      chainId: 80001,
      accounts: [PRIVATE_KEY],
    },
  },

  gasReporter: {
    enabled: true,
  },

  contractSizer: {
    alphaSort: true,
    disambiguatePaths: false,
    runOnCompile: true,
    strict: true,
  },
}
