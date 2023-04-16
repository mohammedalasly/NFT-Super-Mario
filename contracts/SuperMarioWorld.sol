// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "./ERC721.sol";

contract SuperMarioWorld is ERC721 {
    string public name; // ERC721 Mtadata
    string public symbol; // ERC721 Mtadata
    uint256 public tokenCount;

    //* Mapping
    mapping(uint256 => string) private _tokenURIs;

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

    //* return the url that points to the Metadata
    function tokenURI(uint256 tokenId) public view returns (string memory) {
        // ERC721 Mtadata
        require(_owners[tokenId] != address(0), "Token ID does not exist");
        return _tokenURIs[tokenId];
    }

    //* Create a new NFT inside our collection
    function mint(string memory _tokenURI) public {
        tokenCount += 1; // Update tokenCount
        _balances[msg.sender] += 1;
        _owners[tokenCount] = msg.sender;
        _tokenURIs[tokenCount] = _tokenURI;
        emit Transfer(address(0), msg.sender, tokenCount);
    }

    function supportInterface(bytes4 interfaceId) public pure override returns (bool) {
        return interfaceId == 0x80ac58cd || interfaceId == 0x5b5e139f;
    }
}
