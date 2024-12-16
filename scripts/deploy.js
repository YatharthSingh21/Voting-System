const hre = require("hardhat");

async function main() {
    // Get the contract factory
    const Voting = await hre.ethers.getContractFactory("Voting");

    // Deploy the contract
    const voting = await Voting.deploy(); // Deploy the contract instance

    await voting.waitForDeployment(); // Wait until the deployment is mined

    const result = await voting.getAddress()
    console.log("The contract is deployed at address: ", result);
}

// Run the script
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
