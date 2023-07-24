// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyContract {
    // state variables
    // Some Data types in Solidity
    uint public stateVar = 1;
    string public myString = "Hello world of contract";
    bytes32 public myBytes = "Hello Bytes of contract"; // treats your string more like an array or bytes
    address public myAddress = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4; // Addresses are like username on the blockchain
    struct MyStruct {
        uint256 myUint256;
        string myStrings;
    } // structs are custom datatypes

    // Using the struct
    MyStruct public myStruct = MyStruct(10, "Struct innit");

    // Arrays
    uint[] public uintArray = [1, 2];
    string[] public stringArray = ["Man", "Apple", "Eve"];
    string[] public arrayValue;

    // fn that modifies arrays
    function addValue(string memory _value) public {
        arrayValue.push(_value);
    }

    // getting the length of the array
    function arrayValueCount() public view returns (uint) {
        return arrayValue.length;
    }

    // 2 dimension array: this is an array inside of another array
    uint256[][] public array2D = [[1, 2, 3], [4, 6, 8]];

    // Local Variable
    function getValues() public pure returns (uint) {
        uint value = 1;
        return value;
    }
}
