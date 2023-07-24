// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Inheritance : -> inheriting properties from a parent contract

// Factories : -> Where you deploy other smart contracts within a smart contract

// Interaction : -> How to talk to smart contract inside a smart contract functions to call other contacts on chain

contract Ownable {
    address owner; // person who deployed the smartcontract to the blockchain

    modifier onlyOwner() {
        require(msg.sender == owner, "Must be owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }
}

contract SecretVault {
    string secret;

    constructor(string memory _secret) {
        secret = _secret;
    }

    function getSecret() public view returns (string memory) {
        return secret;
    }
}

// You inherit with the "is" keyword
contract MyContract is Ownable {
    address secretVault; // saving address for reuse

    constructor(string memory _secret) {
        SecretVault _secretVault = new SecretVault(_secret); // Factory
        secretVault = address(_secretVault);
        super;
    }

    function getSecret() public view onlyOwner returns (string memory) {
        return SecretVault(secretVault).getSecret();
    }
}
