const { ethers } = require('hardhat')
require('dotenv').config()

async function main() {
  const factoryContract = await ethers.getContractFactory('SevenDexFactory')
  let factory = await factoryContract.deploy(process.env.FACTORY_FEE_SETTER)
  await factory.deployed()
  console.log(`Factory Contract Address:\n${factory.address}`)
}

main()
  .then(() => {})
  .catch((error) => {
    console.log(error)
    process.exit(1)
  })
