//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.1;

import "hardhat/console.sol";

// Helper encode in Base64
import "./libraries/Base64.sol";

//OpenZeppelin ERC721 standard smart contract
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract DungeonFighter is ERC721 {
    //Character NFT properties
    struct CharacterAttributes {
        uint256 characterId;
        string name;
        string imgURI;
        uint256 lvl;
        uint256 hp;
        uint256 maxHp;
        uint256 attack;
        uint256 agility;
        uint256 magic;
        uint256 critChance;
    }

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    //Holds the default data for characters
    CharacterAttributes[] defaultCharacters;

    //Stores state of player's NFT
    mapping(uint256 => CharacterAttributes) nftHolderAttributes;

    //Stores the owner of the NFT
    mapping(address => uint256) nftHolders;

    constructor(
        string[] memory charactersNames,
        string[] memory charactersImagesURIs,
        uint256[] memory charactersLvls,
        uint256[] memory charactersHps,
        uint256[] memory charactersAttacks,
        uint256[] memory charactersAgilities,
        uint256[] memory charactersMagics,
        uint256[] memory characterCritChances
    ) ERC721("DungeonFighters", "DF") {
        //Loop through all the characters, and save their values in contract
        for (uint256 i = 0; i < charactersNames.length; i++) {
            defaultCharacters.push(
                CharacterAttributes({
                    characterId: i,
                    name: charactersNames[i],
                    imgURI: charactersImagesURIs[i],
                    lvl: charactersLvls[i],
                    hp: charactersHps[i],
                    maxHp: charactersHps[i],
                    attack: charactersAttacks[i],
                    agility: charactersAgilities[i],
                    magic: charactersMagics[i],
                    critChance: characterCritChances[i]
                })
            );
            CharacterAttributes memory c = defaultCharacters[i];

            console.log(
                "Done initializing %s w/ HP %s, img %s",
                c.name,
                c.hp,
                c.imgURI
            );
        }
        _tokenIds.increment();
    }
}
