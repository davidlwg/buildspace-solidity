const main = async () => {
    const [owner, randomPerson] = await hre.ethers.getSigners();

    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const waveContract = await waveContractFactory.deploy();
    await waveContract.deployed();

    console.log("Contract address:", waveContract.address);
    console.log("Contract owner:", owner.address);

    let waveCount;
    waveCount = await waveContract.getTotalWaves();

    let waveTxn = await waveContract.add();
    await waveTxn.wait();
    waveCount = await waveContract.getTotalWaves();

    waveTxn = await waveContract.connect(randomPerson).sub();
    await waveTxn.wait();
    waveCount = await waveContract.getTotalWaves();

    // waves per person
    let allAddyTxn = await waveContract.printAllAddys();
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
