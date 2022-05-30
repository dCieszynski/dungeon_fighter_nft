const main = async () => {
  const dungeonFighterFactory = await hre.ethers.getContractFactory(
    "DungeonFighter"
  );
  const dungeonFighterContract = await dungeonFighterFactory.deploy(
    ["Knight", "Hunter", "Wizard"], //Names
    [
      "https://gateway.pinata.cloud/ipfs/QmeSsA6wJ3Fa48SWG8EnbFNMjvAkrBth4vcmzvdEKvPzgp/knight.gif",
      "https://gateway.pinata.cloud/ipfs/QmeSsA6wJ3Fa48SWG8EnbFNMjvAkrBth4vcmzvdEKvPzgp/hunter.gif", //Images
      "https://gateway.pinata.cloud/ipfs/QmeSsA6wJ3Fa48SWG8EnbFNMjvAkrBth4vcmzvdEKvPzgp/wizard.gif",
    ],
    [1, 1, 1], //Levels
    [150, 100, 80], //Hp
    [10, 15, 5], //Attack
    [5, 20, 10], //Agility
    [5, 10, 20], //Magic
    [2, 20, 10] //CritChance);
  );

  await dungeonFighterContract.deployed();
  console.log("Contract deployed to: ", dungeonFighterContract.address);

  let txn1 = await dungeonFighterContract.mintCharacterNFT(0);
  await txn1.wait();
  console.log("Minted NFT #1");

  let txn2 = await dungeonFighterContract.mintCharacterNFT(1);
  await txn2.wait();
  console.log("Minted NFT #2");

  let txn3 = await dungeonFighterContract.mintCharacterNFT(2);
  await txn3.wait();
  console.log("Minted NFT #3");

  console.log("Done deploying and minting!");
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log("ERROR: ", error);
    process.exit(1);
  }
};

runMain();
