// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// first contract deployed address through remix -> 0x0E0E41c880b6982d41E4fcBAaab95c425389a260

//Some of EVM data structures
// calldata -> calldata means that the value is only going to exist temporarily during the txn fn is called: NB -> You only use calldata when you don't want to modify the data or name because it is a temp variable that cant be modified
// memory -> memory means that the value is only going to exist temporarily during the txn fn is called: NB -> it is a temp variable that can be modified
// storage -> storage variable exist  even outside just the function executing

contract SimpleStorage {
    uint256 public favoriteNumber;

    // In other for a function to be overrideable in solidity you need to add the virtual keyword to the fn.. e.g function store() public override {}
    function store(uint256 _favoriteNumber) public virtual {
        favoriteNumber = _favoriteNumber;
    }

    // Basic solidity Array
    // uint[] public people = [1]; // this is a dynamic array bcs the size of the array is not given at the initialization
    // uint[3] public staticArray = [] -> this is a static array with the size of 3
    People[] public people;

    // struct type
    struct People {
        uint favoriteNumber;
        string name;
    }

    // using the struct
    People public person = People({favoriteNumber: 5, name: "Common"});

    // mapping
    mapping(string => uint256) public nameToFavoriteNumber; // mapping initialize everything to its null value when created

    // the view function doesn't change the state of the blockchain, and also doesn't spend gas to run, it only reads it
    function retrieve() public view returns (uint256) {
        return favoriteNumber;
    }

    // fn to add people to the People array
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        // adding people to the People array with the push method
        people.push(People(_favoriteNumber, _name)); // the capilatized people is refering to the struct "People" while the lowercase is referring to the array
        // People memory newPerson = People({favoriteNumber :_favoriteNumber, name :_name}); // when assigned to a variable
        // people.push(newPerson);

        //
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}
