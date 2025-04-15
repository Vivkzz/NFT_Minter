// SPDX-License-Identifier: SEE LICENSE IN LICENSE

/// @title NFTMinter
/// @author Vivek Tanna
/// @notice This is a basic NFT minter contract where user will able to mint NFTs by paying a fixed price
/// also owner of the contract can withdraw the total balance of the contract
/// @dev This contract uses OpenZeppelin's ERC721 and Ownable contracts

pragma solidity ^0.8.20;

import {ERC721URIStorage, ERC721} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract NFTMinter is ERC721URIStorage, Ownable {
    error NFTMinter_insufficientPrice();
    error NFTMinter_failedToTransfer();

    uint256 private _nextTokenId;
    uint256 public constant MINT_PRICE = 0.01 ether;

    constructor() ERC721("TestNFT", "TNFT") Ownable(msg.sender) {}

    function mint(address to, string memory URI) external payable {
        if (msg.value < MINT_PRICE) {
            revert NFTMinter_insufficientPrice();
        }

        // starts from 0
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, URI);
    }

    /// @notice It will only be called by contract owner not by users
    function withdraw() external onlyOwner {
        // payable(owner()).transfer(address(this).balance);
        (bool success,) = owner().call{value: address(this).balance}("");
        if (!success) {
            revert NFTMinter_failedToTransfer();
        }
    }
}
