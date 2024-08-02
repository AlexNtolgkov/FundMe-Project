-include .env

build:; forge build

deploy-sepolia:
	forge script script/DeployFundMe.s.sol:DeployFundMe \
		--rpc-url http://127.0.0.1:8545 \
		--account HelloWallet \
		--sender 0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266 \
		--broadcast
