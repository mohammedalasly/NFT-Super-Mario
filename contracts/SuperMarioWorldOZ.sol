// contracts/GameItem.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract SuperMarioWorldOZ is ERC721URIStorage {
    using Counters for Counters.Counter; // Counters library allows us Increment, decrement, and reset a value
    Counters.Counter private _tokenIds;

    // inject to erc721 constructor
    constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) {}

    function mint(string memory tokenURI) public returns (uint256) {
        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);

        _tokenIds.increment(); // increment the token ID by 1
        return newItemId;
    }
}
