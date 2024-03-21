const { ethers } = require('hardhat')
require('dotenv').config()

async function main() {
  const feeContract = await ethers.getContractFactory('SevenDexFee')
  let fee = await feeContract.deploy(process.env.FEE_SETTER)
  await fee.deployed()
  console.log(`Fee Contract Address:\n${fee.address}`)
}

main()
  .then(() => {})
  .catch((error) => {
    console.log(error)
    process.exit(1)
  })
