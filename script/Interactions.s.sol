//SPDX-License-Identifier: MIT
pragma solidity 0.8.19;
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {Script, console} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
contract FundFundMe is Script {
    uint256 constant SEND_VALUE = 0.01 ether;
    address USER = makeAddr ("funder");

    function run() external{
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        vm.startBroadcast();
        fundFundMe(mostRecentlyDeployed);
        vm.stopBroadcast();

    }

    function fundFundMe(address mostRecentlyDeployed) public {
        vm.deal(USER, 1e18);
        vm.prank(USER);
        FundMe(payable(mostRecentlyDeployed)).fund{value: SEND_VALUE}();
        console.log("Did not send enough %s ETH", SEND_VALUE);
    }

}

contract WithdrawFundMe is Script{
    uint256 constant SEND_VALUE = 0.01 ether;
    function withdrawFundMe(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).withdraw();
        vm.stopBroadcast();
    }

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        withdrawFundMe(mostRecentlyDeployed);
    }

}



