// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConverter} from "../src/PriceConverter.sol";
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

error FundMe__NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    mapping(address => uint256) private s_addressToAmountFunded;
    address[] private s_funders;

    address private  i_owner;
    uint256 public constant MINIMUM_USD = 5e18;
    AggregatorV3Interface private s_PriceFeed;

    constructor(address PriceFeed) {
        i_owner = msg.sender;
        s_PriceFeed = AggregatorV3Interface(PriceFeed);

    }

    function fund() public payable {
        require(msg.value.getConversionRate(s_PriceFeed) >= MINIMUM_USD, "You need to spend more ETH!");
        s_addressToAmountFunded[msg.sender] += msg.value;
        s_funders.push(msg.sender);
    }

    function getVersion() public view returns (uint256) {
        return s_PriceFeed.version();
    }

    modifier onlyOwner() {
        if (msg.sender != i_owner) revert FundMe__NotOwner();
        _;
    }

     function withdraw() public onlyOwner {
        uint256 fundersLength = s_funders.length;
        for(uint256 funderindex = 0; funderindex < fundersLength; funderindex++){
            address funder = s_funders[funderindex];
            s_addressToAmountFunded[funder] = 0;
        }
        s_funders = new address[](0);
          (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");

    }

   

    fallback() external payable {
        fund();
    }

    receive() external payable {
        fund();
    }

    function getAddresstoAmountFunded(address fundingAddress ) external view returns(uint256){
        return s_addressToAmountFunded[fundingAddress];
    }

    function getFunders(uint256 _index) external view returns(address) {
        return s_funders[_index];
    }

    function getOwner() external view returns(address){
        return i_owner;
    }

   
    }

