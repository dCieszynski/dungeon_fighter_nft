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
    constructor() ERC721("DungeonFighters", "DF") {
        console.log("Contract initialized");
    }
}
