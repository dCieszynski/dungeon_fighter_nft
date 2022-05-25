const main = async () => {
  const dungeonFighterFactory = await hre.ethers.getContractFactory(
    "DungeonFighter"
  );
  const dungeonFighterContract = await dungeonFighterFactory.deploy(
    ["Knight", "Hunter", "Wizard"], //Names
    [
      "https://gateway.pinata.cloud/ipfs/QmP3ZXRNgDRVBAAEmBWWvyK8q3oU3SRYXLWdLkoJF2HCik/knight.gif",
      "https://gateway.pinata.cloud/ipfs/QmP3ZXRNgDRVBAAEmBWWvyK8q3oU3SRYXLWdLkoJF2HCik/hunter.gif", //Images
      "https://gateway.pinata.cloud/ipfs/QmP3ZXRNgDRVBAAEmBWWvyK8q3oU3SRYXLWdLkoJF2HCik/wizard.gif",
    ],
    [1, 1, 1], //Levels
    [150, 100, 80], //Hp
    [10, 15, 5], //Attack
    [5, 20, 10], //Agility
    [5, 10, 20], //Magic
    [2, 20, 10] //CritChance
  );
  await dungeonFighterContract.deployed();
  console.log("Contract deployed to: ", dungeonFighterContract.address);

  let txn = await dungeonFighterContract.mintCharacterNFT(1);
  await txn.wait();

  let returnedTokenURI = await dungeonFighterContract.tokenURI(1);
  console.log("Token URI: ", returnedTokenURI);
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
