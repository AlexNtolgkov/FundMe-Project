//SPDX-License-Identifier: MIT
pragma solidity 0.8.19;
import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
contract FundMeTest is Test{

    FundMe fundMe;
    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;
 
    function setUp() public {
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, STARTING_BALANCE);
    }

    function testMINIMUMUSDisfive() public view {
        console.log("Hello, Mom");  
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerisMSGSender() public view {
        console.log(msg.sender);
        console.log(address(this)); 
        assertEq(fundMe.getOwner(), msg.sender);
    }

    function testPriceFeedVersionisAccurate() public view {
        uint256 version = fundMe.getVersion();
        assertEq(version, 4);
    }   

   function testToolittleETHethsentthroughFund() public {
    vm.expectRevert();
    fundMe.fund();
   }

   function testDataStructuresUpdatedwhenETHsent() public {
    vm.prank(USER);
    fundMe.fund{value: 10e18}();
    uint256 amountFunded = fundMe.getAddresstoAmountFunded(USER);
    assertEq(amountFunded, 10e18);
   }

   //1 
   function testArrayaddsaddressfunded() public {
    vm.prank(USER);
    fundMe.fund{value: 10e18}();
    address funder = fundMe.getFunders(0);
    assertEq(funder, USER);
   }

   modifier funded() {
    vm.prank(USER);
    fundMe.fund{value: 10e18};
    _;
   }

 //2

 function testOnlyOwnercanWithdraw2() public  {
    vm.prank(USER);
    vm.expectRevert();
    fundMe.withdraw();
 }
 
function testWithdrawwithaSingleFunder() public funded {
    //arrange
    uint256 startingOwnerBalance = fundMe.getOwner().balance;
    uint256 startingFundingBalance = address(fundMe).balance;
    //act
    vm.prank(fundMe.getOwner());
    fundMe.withdraw();
    //assert
    uint256 endingOwnerBalance = fundMe.getOwner().balance;
    uint256 endingFundMeBalance = address(fundMe).balance;
    assertEq(endingFundMeBalance, 0);
    assertEq(startingFundingBalance + startingOwnerBalance, endingOwnerBalance);
}
function testWithdrawfromMultipleFunders() public  {
    //arrange
    uint160 numberofFunders = 10;
    uint160 startingFunderIndex = 1;
    for(uint160 i = startingFunderIndex; i < numberofFunders; i++){
        hoax(address(i), SEND_VALUE);
        fundMe.fund{value: SEND_VALUE}();}
    uint256 startingOwnerBalance = fundMe.getOwner().balance;
    uint256 startingFundMeBalance = address(fundMe).balance;
    //act
    vm.startPrank(fundMe.getOwner());
    fundMe.withdraw();
    vm.stopPrank();
    //assert
    assert(address(fundMe).balance == 0);
    assert(startingFundMeBalance + startingOwnerBalance == fundMe.getOwner().balance);
    }
}

//   function withdraw() public onlyOwner {
//         uint256 fundersLength = s_funders.length;
//         for(uint256 funderindex = 0; funderindex < fundersLength; funderindex++){
//             address funder = s_funders[funderindex];
//             s_addressToAmountFunded[funder] = 0;
//         }
//         s_funders = new address[](0);
//           (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
//         require(callSuccess, "Call failed");

//     }
