// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {NFTMinter} from "../src/NFTMinter.sol";
import {console} from "forge-std/console.sol";

contract DeployNFTMinter is Script {
    function run() external {
        vm.startBroadcast();
        NFTMinter nftMinter = new NFTMinter();
        vm.stopBroadcast();
        console.log("NFTMinter deployed to:", address(nftMinter));
    }
}
