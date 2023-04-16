// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

/// @title ERC-721 Non-Fungible Token Standard
/// @dev See https://eips.ethereum.org/EIPS/eip-721
///  Note: the ERC-165 identifier for this interface is 0x80ac58cd.

contract ERC721 {
    //* Events / // Indexed: helps ppl search through the event logs
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);
    event Approval(address indexed _owner, address indexed _approved, uint256 _tokenId);
    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);

    //* State Variable (Mapping)
    mapping(address => uint256) internal _balances; // to track the balances
    mapping(uint256 => address) internal _owners; // track who owns an NFT
    mapping(address => mapping(address => bool)) private _operatorApprovals; // nested mapping, track operators
    mapping(uint256 => address) private _tokenApprovals; // track the Approvals

    //* Return the number of NFTs assigned to an owner
    function balanceOf(address owner) public view returns (uint256) {
        require(owner != address(0), "Address is zero"); // error checking(checking the input is not a zero address)
        return _balances[owner]; // return the balances of the owner
    }

    //* Findes the owner of an NFT
    function ownerOf(uint256 tokenId) public view returns (address) {
        address owner = _owners[tokenId]; // add the owner of the tokenId
        require(owner != address(0), "TokenID does not exsist!");
        return owner;
    }

    //* Enable or disable an operator to manage all of msg.senders assets.
    function setApprovalForAll(address operator, bool approved) public {
        _operatorApprovals[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved); // Emit ApprovalForAll
    }

    //* Checkes if an address is an operator for another address
    function isApprovedForAll(address owner, address operator) public view returns (bool) {
        return _operatorApprovals[owner][operator];
    }

    //* Update an approved address for an NFT
    function approve(address to, uint256 tokenId) public {
        address owner = ownerOf(tokenId); // define the owner
        require(
            msg.sender == owner || isApprovedForAll(owner, msg.sender),
            "Msg.sender is not the owner or an approved operator"
        );
        // with the new mapping tokenID, we can iput the tokenID, and set the approved person to be the (to) variable
        _tokenApprovals[tokenId] = to;
        emit Approval(owner, to, tokenId);
    }

    //* Gets the approved address for a single NFT
    function getApproved(uint256 tokenId) public view returns (address) {
        require(_owners[tokenId] != address(0), "Token ID does not exists"); // check if the tokenID is mapped to an invaled NFT by using the owners mapping
        return _tokenApprovals[tokenId];
    }

    //* Transfers ownership of an NFT
    function transferFrom(address from, address to, uint256 tokenId) public {
        address owner = ownerOf(tokenId);
        require(
            msg.sender == owner ||
                getApproved(tokenId) == msg.sender ||
                isApprovedForAll(owner, msg.sender),
            "Msg.sender is not the owner or approved transfer"
        );
        require(owner == from, "From address is not the owner"); // check if (from) is not the current owner
        require(to != address(0), "Address is zero"); // check if the (to) address is a zero address
        require(_owners[tokenId] != address(0), "TokenID does not exist"); // if the token ID is not a valid NFT
        // transfering the token form account to another, clear out all the previous approvals tha the owner has done
        approve(address(0), tokenId);
        // update the balances
        _balances[from] -= 1;
        _balances[to] += 1;
        _owners[tokenId] = to; // update the owner of the token
        emit Transfer(from, to, tokenId); // Emit Transfer
    }

    //* Checkes if onERC721Received is implemented when sendeing to smart contracts
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) public {
        transferFrom(from, to, tokenId);
        require(_checkOnERC721Received(), "Receiver not implemented");
    }

    function safeTransferFrom(address from, address to, uint256 tokenId) public {
        safeTransferFrom(from, to, tokenId, "");
    }

    //* Oversimplified
    function _checkOnERC721Received() private pure returns (bool) {
        return true;
    }

    //* Support Interface Function
    // EIP165: Query if a contract implements another interface
    function supportInterface(bytes4 interfaceId) public pure virtual returns (bool) {
        return interfaceId == 0x80ac58cd; // bytes4 variable
    }
}
