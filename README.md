# FundMe Smart Contract Project

## Overview

The FundMe Smart Contract project is a decentralized application built on the Ethereum blockchain. The primary objective of this project is to allow users to contribute funds and for the contract owner to withdraw the funds. The project leverages Chainlink price feeds to ensure that users contribute a minimum amount in USD, regardless of the volatility in ETH prices.

## Project Structure

The project is organized into several folders, each containing specific contracts and test files:

## Script Folder: 

Contains deployment and interaction scripts for the contracts.

## src Folder: 

Contains the main contract and library code.

## test Folder: 

Contains unit and integration tests to verify the functionality of the contracts.

## script Folder

## DeployFundMe.sol

This script handles the deployment of the FundMe contract. It retrieves the appropriate price feed address depending on the active network configuration (e.g., Sepolia, Mainnet, or Anvil) and deploys the contract.

## HelperConfig.sol

This script defines the network configurations and retrieves or creates the appropriate price feed address depending on the active blockchain network.

## Interactions.s.sol

Contains two scripts: FundFundMe and WithdrawFundMe.

## FundFundMe

Script to fund the FundMe contract with a specified amount of ETH.

## WithdrawFundMe

Script to withdraw the funds from the FundMe contract by the owner.

## Src Folder

FundMe.sol

The main contract that handles funding and withdrawal functionalities. It ensures a minimum amount of USD is contributed using the Chainlink price feeds.

## PriceConverter.sol

A library used by the FundMe contract to convert ETH to USD using Chainlink price feeds.

## Test Folder

Integration Tests Folder

Contains tests that simulate real-world scenarios and interactions between different contracts. These tests ensure the overall integration of the contract's functionalities.

# Mocks Folder

Contains mock contracts used to simulate external dependencies (e.g., Chainlink price feeds) during testing.

# Unit Tests Folder

Contains unit tests that focus on testing individual components of the FundMe contract. It verifies that the contract behaves as 
expected under various conditions.

# Dependencies

Foundry: A development framework for building and testing Solidity smart contracts.

Chainlink: Used for integrating decentralized price feeds into the FundMe contract.
Usage

## Deploying the Contract:

Run the DeployFundMe script to deploy the FundMe contract to the desired network. The script will automatically select the appropriate price feed based on the active network.

# Funding the Contract:

Use the FundFundMe script to fund the FundMe contract with ETH. Ensure that the ETH amount converted to USD meets the minimum requirement.

## Withdrawing Funds:

Only the owner can withdraw funds using the WithdrawFundMe script. The contract will transfer all collected ETH to the owner's address.

## Testing:

Run the unit and integration tests provided in the test folder to ensure all functionalities are working correctly.
License

This project is licensed under the MIT License.