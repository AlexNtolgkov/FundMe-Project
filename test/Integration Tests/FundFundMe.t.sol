//SPDX-License-Identifier: MIT
pragma solidity 0.8.19;
import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {FundFundMe, WithdrawFundMe} from "../../script/Interactions.s.sol";
contract InteractionsTest is Test {

    FundMe fundMe;
    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;
    uint256 constant GAS_PRICE = 1;

    DeployFundMe deployFundMe;

    function setUp() external {
        DeployFundMe deploy = new DeployFundMe();
        fundMe = deploy.run();
        vm.deal(USER, STARTING_BALANCE);
    }

    function testUserCanFund() public {

        FundFundMe fundFundMe = new FundFundMe();
        fundFundMe.fundFundMe(payable(address(fundMe)));

        WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
        withdrawFundMe.withdrawFundMe(payable(address(fundMe)));
        
        assert(address(fundMe).balance == 0);
    } 

}