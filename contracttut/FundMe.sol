// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./PriceConverter.sol";

// import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

// this is a contract that allows people to fund, send eth, polygon or avalanche into this contract and the owner is allowed to withdraw
// Get funds from users
// withdraw funds
// set a minimum funding value in USD

// constant keyword -> when the variable is to be set once and never changes and it spends less gas and also cheaper to read from e.g MINIMUM_USD
// immutable keyword -> variable that is set one time but outside of the dame line that they are declared we can mark as immutable, e.g owner
// the reason that this two saves gas is because instead of storing this variables inside of a storage slot, it actually store them directly into the byte code of the contract

// Custom error
error NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    uint public constant MINIMUM_USD = 30; // setting the minimum value that can be sent in USD

    // keeping track of all the people who sent money
    address[] public funders;

    mapping(address => uint256) public addressToAmountFunded;

    address public immutable i_owner;

    constructor() {
        i_owner = msg.sender;
    }

    // fund fn -> the payable keyword makes the function payable with any cryptocurrency you're working with or receiving
    function fund() public payable {
        // setting a minimum amount in usd, thing to consider here
        // 1. How do we send ETH to this contract

        // require(msg.value >= 0.9e18, "Not enough balance"); // 1e18 = 1 * 10^18,
        // require(getConversionRate(msg.value) >= minimumUsd, "Value not upto required minimum amount");
        require(
            msg.value.getConversionRate() >= MINIMUM_USD,
            "Value not upto required minimum amount"
        );
        funders.push(msg.sender); // the address of whoever calls the fund fn
        addressToAmountFunded[msg.sender] = msg.value;
        // reverting is when solidity undo any action before, and send remaining gas back if the condition set on the require() is not met
    }

    modifier onlyOwner() {
        // require(msg.sender == i_owner, "You must be an owner to withdraw funds");
        if (msg.sender != i_owner) {
            revert NotOwner(); // the revert keyword does the exact same thing the require method does
        } // this custom error method is more gas efficient than the require method.
        _;
    }

    function withdraw() public onlyOwner {
        /* looping through the list the funders */
        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            //code
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        // resetting an array
        funders = new address[](0);

        //withdraw -> there are 3 different ways to withdraw funds from solidity which are
        // transfer
        // send
        // call

        // msg.sender = address
        // payable(msg.sender) = payable address

        // transfer
        // payable(msg.sender).transfer(address(this).balance); // if it fails it throws an error

        // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance); // if it fails it returns a boolean of wether or not it was successful
        // require(sendSuccess, "sending failed");

        // call
        // call function returns 2 variables placed in a bracket like tuples
        (bool callSuccess, bytes memory dataReturned) = payable(msg.sender)
            .call{value: address(this).balance}("");
        require(callSuccess, "call failed"); // using call is the recommended way to send and receive native tokens
    }

    // ADVANCE SOLIDITY RECEIVE & FALLBACK
    // what happens if someone sends this contract ETH without calling the fund fn
    // receive() ->  a receive fn gets triggered anytime a transaction is sent to a contract, it is a special keyword in solidity, receive is only triggered if our calldata to it is blank
    // fallback()

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
}
