const { ethers } = require("hardhat")

async function main() {
    // const SuperMarioWorld = await ethers.getContractFactory("SuperMarioWorld")
    // const SuperMarioWorld = await ethers.getContractFactory("SuperMarioWorldOZ")
    const SuperMarioWorld = await ethers.getContractFactory("SuperMarioWorldERC1155")
    // const SuperMario = await SuperMarioWorld.deploy("SuperMarioWorldERC1155", "SMW") // deploy our smart contract
    // const SuperMario = await SuperMarioWorld.deploy("SuperMarioWorldERC1155", "SMWO")
    const SuperMario = await SuperMarioWorld.deploy("SuperMarioWorldERC1155", "SMWE")
    await SuperMario.deployed() // wait for the contract to be deployed before we do anything forther
    console.log("Success! Contract was deployed to: ", SuperMario.address) // to print the contract address

    // await SuperMario.mint("https://ipfs.io/ipfs/Qmch3m7DEFYRaZiFG6gc8qgkBMS3nrTvM5h5v9xZK6rGEz") // mint mario NFT
    // await SuperMario.mint("https://ipfs.io/ipfs/QmYoVjXNGbAVHKucFJ3xw8MMxWqFXHtyWPLzf4EB8aLW4f") // mint luigi NFT
    await SuperMario.mint(10, "https://ipfs.io/ipfs/QmUYMgqe6AQVaw2UjYJ2NdAEdRnSB2k6VdMnHjhQ1swvMG") // mint yoshi NFT(ERC1155)
    console.log("NFT successfully minted!")
}
main().catch((error) => {
    console.error(error)
    process.exitCode = 1
})
