## FundMe Smart Contract Project
## Overview

The FundMe Smart Contract is a decentralized application built on Ethereum that allows users to contribute funds. The contract owner can then withdraw these funds. This project uses Chainlink price feeds to ensure that contributions meet a minimum USD value, regardless of ETH's price fluctuations.

# Project Structure

The project is organized into several folders:

Script Folder: Contains deployment and interaction scripts for the contracts.
Src Folder: Contains the main contract and library code.
Test Folder: Contains unit and integration tests to verify the contract's functionality.

# Setup Instructions

## Install Dependencies:

Ensure you have Foundry installed.

## Clone the Repository:


``` 
git clone https://github.com/SpooonyBard/Foundry-fund-me-f24.git
```

```
cd fundme
```



## Environment Setup:

Set up environment variables if required, particularly for network configurations and API keys.
Usage

## Deploying the Contract:

Deploy the FundMe contract using the provided script:

``` forge script script/DeployFundMe.s.sol --rpc-url <YOUR_RPC_URL> --broadcast ```

## Funding the Contract:

Use the FundFundMe script to fund the contract:

``` forge script script/Interactions.s.sol:FundFundMe --rpc-url <YOUR_RPC_URL> --broadcast ```

**Ensure the ETH amount converted to USD meets the minimum requirement.
**

## Withdrawing Funds:

**Only the contract owner can withdraw funds using the WithdrawFundMe script:
**

``` forge script script/Interactions.s.sol:WithdrawFundMe  --rpc-url <YOUR_RPC_URL> --broadcast ```

## Testing

## Running Unit Tests:
Run the following command to execute unit tests:

``` forge test --mt <NAME_OF_FUNCTION_TO_BE_TESTED> ```

Running Integration Tests:

Execute integration tests with:

``` forge test --mt <NAME_OF_FUNCTION_TO_BE_TESTED> ```

## Project Details

DeployFundMe.sol: Deploys the FundMe contract based on the active network configuration.

HelperConfig.sol: Defines network configurations and retrieves or creates price feed addresses.

FundMe.sol: Main contract handling funding and withdrawal with Chainlink price feed integration.

PriceConverter.sol: A library for converting ETH to USD using Chainlink price feeds.

## License

This project is licensed under the MIT License.