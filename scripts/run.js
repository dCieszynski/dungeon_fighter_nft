const main = async () => {
  const dungeonFighterFactory = await hre.ethers.getContractFactory(
    "DungeonFighter"
  );
  const dungeonFighterContract = await dungeonFighterFactory.deploy();
  await dungeonFighterContract.deployed();
  console.log("Contract deployed to: ", dungeonFighterContract.address);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log("Error: ", error);
    process.exit(1);
  }
};

runMain();
