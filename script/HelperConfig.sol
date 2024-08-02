//SPDX-License-Identifier: MIT
pragma solidity 0.8.19;
import {Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/Mocks/MockV3Aggregator.sol";
contract HelperConfig is Script{

    NetworkConfig public ActiveNetworkConfig;
    uint8 public constant DECIMALS = 8;
    int256 public constant INITIAL_PRICE = 2000e8;

    struct NetworkConfig {
        address priceFeed;
    }

    constructor() {
        if(block.chainid == 11155111){
            ActiveNetworkConfig = getSepoliaETHconfig();
        }
        else if(block.chainid == 1){
            ActiveNetworkConfig = getETHMainnetConfig();
        }
        else {ActiveNetworkConfig = getORcreateAnvilConfig();}
    }


    function getSepoliaETHconfig() public pure returns(NetworkConfig memory){
        NetworkConfig memory SepoliaConfig = NetworkConfig({priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306});
        return SepoliaConfig;
    }

    function getETHMainnetConfig() public pure  returns(NetworkConfig memory) {
        NetworkConfig memory ETHMainnetConfig = NetworkConfig({priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419});
        return ETHMainnetConfig;
    }

    function getORcreateAnvilConfig() public returns(NetworkConfig memory) {
        if (ActiveNetworkConfig.priceFeed != address (0)){
            return ActiveNetworkConfig;
        }

        vm.startBroadcast();
        MockV3Aggregator mockPriceFeed = new MockV3Aggregator(DECIMALS, INITIAL_PRICE);
        vm.stopBroadcast();     
        NetworkConfig memory anvilConfig = NetworkConfig({priceFeed: address(mockPriceFeed)});
        return anvilConfig;
    }

}