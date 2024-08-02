//SPDX-License-Identifier: MIT
pragma solidity 0.8.19;
import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "./HelperConfig.sol";
contract DeployFundMe is Script{

    HelperConfig helperConfig = new HelperConfig();
    address ETHUSDpriceFeed = helperConfig.ActiveNetworkConfig();

    function run() external returns(FundMe) {
        vm.startBroadcast();
       FundMe fundMe = new FundMe(ETHUSDpriceFeed);
        vm.stopBroadcast();
        return fundMe;

    }
}