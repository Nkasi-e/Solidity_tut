// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./SimpleStorage.sol";

// Inheritance to access the SimpleStorage functions

contract ExtraStorage is SimpleStorage {
    // want to add 5 to any anumber we give the storage fn
    //override the function with two keywords which are
    // virtual override

    // In other for a function to be overrideable in solidity you need to add the virtual keyword to the fn.. e.g function store() public override {}
    function store(uint _favoriteNumber) public override {
        favoriteNumber = _favoriteNumber + 5;
    }

    //Note: Only virtual functions can be overriden when inherited from a contract, this means fn with the virtual keyword, and they can only be overriden with an override function, meaning a function with the override keyword
}
