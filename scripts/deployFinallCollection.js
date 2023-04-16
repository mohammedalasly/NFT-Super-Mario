const { ethers } = require("hardhat")

async function main() {
    const SuperMarioWorld = await ethers.getContractFactory("SuperMarioWorldCollection")
    const SuperMario = await SuperMarioWorld.deploy(
        "SuperMarioWorldCollection",
        "SMWC",
        "https://ipfs.io/ipfs/Qmb6tWBDLd9j2oSnvSNhE314WFL7SRpQNtfwjFWsStXp5A/"
    )
    await SuperMario.deployed()
    console.log("Success! Contract was deployed to: ", SuperMario.address)
    // we mint SuperMarioCollection 10 times for each charictar we have
    // and everytime we hit mint, the token id is going to encrement by 1
    await SuperMario.mint(10) // token id 1 - Mario
    await SuperMario.mint(10) // token id 2 - Luigi
    await SuperMario.mint(10)
    await SuperMario.mint(10)
    await SuperMario.mint(1) // token id 5 - Mario Gold (rare) we make one copy only
    await SuperMario.mint(1) // and so on for the rest of the charictars
    await SuperMario.mint(1)
    await SuperMario.mint(1)
    console.log("NFT successfully minted!")
}
main().catch((error) => {
    console.error(error)
    process.exitCode = 1
})
//*  WE WILL USE THIS ADDRESS ORF OUR SMART CONTRACT WHEN WE WILL DO THE FRONT END DEVELOPMENT *//
// Success! Contract was deployed to:  0xabe7aDA7A76886De4eCE3823C58749D918b0c3CF
