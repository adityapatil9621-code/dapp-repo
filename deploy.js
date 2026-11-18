async function main(){
    const Contract = await ethers.getContractFactory("msgec");
    const contract = await Contract.deploy();

    await contract.waitForDeployment();

    console.log("Contract deployed:", await contract.getAddress());
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});