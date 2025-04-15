// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {NFTMinter} from "../src/NFTMinter.sol";

contract NFTMinterTest is Test {
    NFTMinter nftMinter;
    address user1 = address(1);
    address owner = address(2);

    function setUp() public {
        vm.startPrank(owner);
        nftMinter = new NFTMinter();
        vm.stopPrank();
        vm.deal(user1, 1 ether);
      
    }

    function testMintNFT() public {
        vm.startPrank(user1);
        nftMinter.mint{value: 0.01 ether}(user1, "https://example.com/1");
        vm.stopPrank();

        assertEq(nftMinter.balanceOf(user1), 1);
        assertEq(nftMinter.ownerOf(0), user1);
    }

    function testMintWithoutPayment() public {
        vm.startPrank(user1);
        vm.expectRevert(NFTMinter.NFTMinter_insufficientPrice.selector);
        nftMinter.mint{value: 0.005 ether}(user1, "https://example.com/1");
        vm.stopPrank();
    }

    function testWithdraw() public {
        vm.startPrank(user1);
        nftMinter.mint{value: 0.01 ether}(user1, "https://example.com/1");
        vm.stopPrank();

        uint256 balanceBefore = owner.balance;

        vm.startPrank(owner);
        nftMinter.withdraw();
        vm.stopPrank();
        assertEq(owner.balance, balanceBefore + 0.01 ether);
    }

    // still can do many more test .... 
}
