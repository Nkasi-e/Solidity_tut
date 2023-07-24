// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyMapping {
    // Mapping are datatype that allows you to store data on the blockchain with key-value pairs, similar to dictionary in Python and Objects in Javascript
    // mapping(key => value)
    mapping(uint => string) public names;

    // NB: the constructor fn runs only once whenever the smartcontract is been deployed to the blockchain
    // Assigning stuffs to the mapping by creating a constructor fn
    constructor() {
        names[1] = "Nkasi"; // the [] is to either add something/info to the mapping or access it
        names[2] = "Chidera";
        names[3] = "contract";
    }

    // How to use a mapping to make the blockchain actually work like a database where you can store complex data: it can work like a traditional database with structs
    struct Book {
        // serves like a db table with diff columns for title and author with an imaginary id
        string title;
        string author;
    }

    mapping(uint => Book) public books; // E.g all the books in the database
    // You can create nested mappings just like we have nested arrays, we can have a mapping of mappings
    // These are usually common for things like tokens, NFTs, when you want to see a balance that is nested under a particular account/address
    mapping(address => mapping(uint => Book)) public myBooks; // the key here is the address of the person who owns the book, then the value is the mapping, which is going to be all the books that belongs to this particular account/address

    //  Adding a book to the mapping
    function addBook(
        uint _id,
        string memory _title,
        string memory _author
    ) public {
        books[_id] = Book(_title, _author);
    }

    function addMyBook(
        uint _id,
        string memory _title,
        string memory _author
    ) public {
        myBooks[msg.sender][_id] = Book(_title, _author); //msg is a global variable
        // msg.sender is the person who is calling the smartcontract, the ethereum address of the person who calls addMyBook
    }
}
