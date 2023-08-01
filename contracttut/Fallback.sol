// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// An example of fallback() and receive() function in solidity
contract FallbackExample {
    uint public result;

    receive() external payable {
        result = 1;
    } // a receive fn gets triggered anytime a transaction is sent to a contract, it is a special keyword in solidity

    fallback() external payable {
        result = 2;
    }
}
