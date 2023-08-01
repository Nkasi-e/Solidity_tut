// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./SimpleStorage.sol";

// in this code we want to be able to deploy contracts from other contracts which is known as factory in solidity -> Able to deploy and interact with other contracts itself.

// the ability for contract to seamlessly interact with each other is known as composibility -> important for DeFi when you can have many contract interact with each other

contract StorageFactory {
    // SimpleStorage is used as an array so that we can store multiple contracts instead of just a single or to just keep a running list of all our contracts
    SimpleStorage[] public simpleStorageArray; // initialize the contract to a varible;

    // creating a fn that will deploy the simpleStorage contrace
    function createSimpleStorageContract() public {
        //simpleStorage = new SimpleStorage(); // saved as a variable
        SimpleStorage simpleStorage = new SimpleStorage(); // saved as a memory variable because of the SimpleStorage declaration
        simpleStorageArray.push(simpleStorage);
    }

    // Interacting with other contracts e.g the SimpleStorage contract

    function sfStore(
        uint _simpleStorageIndex,
        uint _simpleStorageNumber
    ) public {
        // In other for you to interact with any contract you are always going to need the address and ABI of the contract
        // ABI -> Application Binary Interface

        return
            simpleStorageArray[_simpleStorageIndex].store(_simpleStorageNumber); // it can be directly returned like this for short
        //
        // SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageIndex];
        // SimpleStorage simpleStorage = SimpleStorage(simpleStorageArray[_simpleStorageIndex]);

        // calling a function in SimpleStorage contract
        // simpleStorage.store(_simpleStorageNumber);
    }

    // function to read from SimpleStorage contract
    function sfRetrive(uint _simpleStorageIndex) public view returns (uint) {
        return simpleStorageArray[_simpleStorageIndex].retrieve(); // it can be directly returned like this for short

        // SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageIndex];
        // return simpleStorage.retrieve();
    }
}
