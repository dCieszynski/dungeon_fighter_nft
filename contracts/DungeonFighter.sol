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

    //Mint Character
    function mintCharacterNFT(uint256 _characterId) external {
        //Get curennt tokenId
        uint256 newItemId = _tokenIds.current();

        //Assigns the tokenId to the caller's wallet address.
        _safeMint(msg.sender, newItemId);

        //Store NFT data per player
        nftHolderAttributes[newItemId] = CharacterAttributes({
            characterId: _characterId,
            name: defaultCharacters[_characterId].name,
            imgURI: defaultCharacters[_characterId].imgURI,
            lvl: defaultCharacters[_characterId].lvl,
            hp: defaultCharacters[_characterId].hp,
            maxHp: defaultCharacters[_characterId].maxHp,
            attack: defaultCharacters[_characterId].attack,
            agility: defaultCharacters[_characterId].agility,
            magic: defaultCharacters[_characterId].magic,
            critChance: defaultCharacters[_characterId].critChance
        });

        console.log(
            "Minted NFT w/ tokenId %s and characterIndex %s",
            newItemId,
            _characterId
        );

        //Store who owns NFT
        nftHolders[msg.sender] = newItemId;

        _tokenIds.increment();
    }

    function tokenURI(uint256 _tokenId)
        public
        view
        override
        returns (string memory)
    {
        CharacterAttributes memory charAttributes = nftHolderAttributes[
            _tokenId
        ];

        string memory strLvl = Strings.toString(charAttributes.lvl);
        string memory strHp = Strings.toString(charAttributes.hp);
        string memory strMaxHp = Strings.toString(charAttributes.maxHp);
        string memory strAttack = Strings.toString(charAttributes.attack);
        string memory strAgility = Strings.toString(charAttributes.agility);
        string memory strMagic = Strings.toString(charAttributes.magic);
        string memory strCritChance = Strings.toString(
            charAttributes.critChance
        );

        string memory json = Base64.encode(
            abi.encodePacked(
                '{"name": "',
                charAttributes.name,
                " -- NFT #: ",
                Strings.toString(_tokenId),
                '", "description": "Dungeon Fighter NFT", "image": "',
                charAttributes.imgURI,
                '", "attributes": [ { "trait_type": "Health Points", "value": ',
                strHp,
                ', "max_value":',
                strMaxHp,
                '}, { "trait_type": "Level", "value": ',
                strLvl,
                '}, {"trait_type": "Attack", "value": ',
                strAttack,
                '}, {"trait_type": "Agility", "value": ',
                strAgility,
                '}, {"trait_type": "Magic", "value": ',
                strMagic,
                '}, {"trait_type": "CritChance", "value": ',
                strCritChance,
                "} ]}"
            )
        );

        string memory output = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        return output;
    }
}
