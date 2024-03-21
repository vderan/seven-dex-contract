const { ethers } = require('hardhat')
require('dotenv').config()

async function main() {
  const routerContract = await ethers.getContractFactory('SevenDexRouter')
  let router = await routerContract.deploy(
    process.env.FACTORY_ADDRESS,
    process.env.WMATIC_ADDRESS
  )
  await router.deployed()
  console.log(`Router Contract Address:\n${router.address}`)
}

main()
  .then(() => {})
  .catch((error) => {
    console.log(error)
    process.exit(1)
  })
