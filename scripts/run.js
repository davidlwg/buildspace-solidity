const main = async () => {
    const [owner, randomPerson] = await hre.ethers.getSigners();

    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const waveContract = await waveContractFactory.deploy();
    await waveContract.deployed();

    console.log("Contract addy:", waveContract.address);
    console.log("Contract owner:", owner.address);

    let waveCount;
    waveCount = await waveContract.getTotalWaves();
    console.log(waveCount.toNumber());

    /*
       Sending a few waves!
     */

    let waveTxn = await waveContract.wave("A message!");
    await waveTxn.wait(); // wait for transaction to be mined

    waveCount = await waveContract.getTotalWaves();

    waveTxn = await waveContract.connect(randomPerson).wave("Another Message!");
    await waveTxn.wait();

    waveCount = await waveContract.getTotalWaves();
    console.log(waveCount);
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
