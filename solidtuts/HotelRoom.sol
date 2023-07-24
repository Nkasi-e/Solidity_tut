// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Responsible for Booking a hotel room and opening it
/*
    * Concepts it will cover/teach us
    @ Ether Payment
    @ Modifiers
    @ Visibility
    @ Events
    @ Enums
    */

contract HotelRoom {
    enum Statuses {
        Vacant,
        Occupied
    }
    Statuses public currentStatus;

    // Event
    event Occupy(address _occupant, uint _value); // to keep logs or history of txns; to get an alert

    // this is going to be the eth address of the person who created the smart contract
    // payable is a modifier that let address to actually receive eth cryptocurency
    address payable public owner; // model the owner of the hotel room or the smart contract

    constructor() {
        owner = payable(msg.sender); // the person sending
        currentStatus = Statuses.Vacant;
    }

    // Modifier
    modifier onlyWhileVacant() {
        // check status
        require(currentStatus == Statuses.Vacant, "Currently occupied"); //the require fn checks if something is true or false and then perform a custom action
        _;
    }

    modifier costs(uint _amount) {
        // check price
        require(msg.value >= _amount, "Not enough ether provided");
        _;
    }

    // fn to pay the creator of the contract who is going to be the hotel owner
    // And then book the hotel room so that it's open so they can use it
    function book() public payable onlyWhileVacant costs(2 ether) {
        currentStatus = Statuses.Occupied;
        // Pay the owner
        // owner.transfer(msg.value); // the transfer fn sends cryptocurrency to the recipient, in this case is the owner; msg.value is the amount sent

        // there can be some issues with the transfer, so instead of transfer we use call
        // call is not a fn that we can use to send ether around like the transfer fn, we can send a message (arbitrary message) to a recipient but we can also send cryptocurrency this way
        (bool sent, bytes memory data) = owner.call{value: msg.value}(""); // the (bool sent) is to get the status of the txn wether is sent or not
        require(true);
        // calling the even
        emit Occupy(msg.sender, msg.value); // this will send an alert anytime someone books a room
    }
}
