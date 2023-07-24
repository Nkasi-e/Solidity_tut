// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Conditionals {
    // Conditionals: Is a control flow structure, basically a logic gate inside of programming
    // Loops: something that takes over an iterative data structure like an array which has multiple items in it

    // CONDITIONALS
    uint[] public numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

    function isNumberEven(uint _number) public pure returns (bool) {
        if (_number % 2 == 0) {
            return true;
        } else {
            return false;
        }
    }

    // LOOP
    function countEvenNumbers() public view returns (uint) {
        uint count = 0;

        // for loop
        for (uint i = 0; i < numbers.length; i++) {
            if (isNumberEven(numbers[i])) {
                count++;
            }
        }
        return count;
    }

    // Making a one liner if operation like a ternary operator

    address public owner;

    constructor() {
        owner = msg.sender; //
    }

    function isOwner() public view returns (bool) {
        return (msg.sender == owner); // this returns true if the caller of the function is the owner and returns false if they are not
    }
}
