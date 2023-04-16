// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

pragma solidity ^0.8.17;

contract SuperMarioWorldCollection is ERC1155, Ownable {
    string public name;
    string public symbol;
    uint256 public tokenCount;
    string public baseUri;

    constructor(
        string memory _name,
        string memory _symbol,
        string memory _baseUri
    ) ERC1155(_baseUri) {
        name = _name;
        symbol = _symbol;
        baseUri = _baseUri;
    }

    //* Mint Function
    function mint(uint256 amount) public onlyOwner {
        tokenCount += 1;
        // call the internal mint function from openzepplein
        _mint(msg.sender, tokenCount, amount, ""); //
    }

    // we override the uri function from openzeppelin to make our NFTs compatible with opensea
    function uri(uint256 _tokenId) public view override returns (string memory) {
        return
            string(
                abi.encodePacked(
                    baseUri, // take a URL
                    Strings.toString(_tokenId), // add the token Id
                    ".json" // add .jason at the end
                )
            ); // url/tokenid/.json
    }
}
