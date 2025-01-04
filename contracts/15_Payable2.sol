// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract PayableConsructor{
    address public owner;
    uint public initialBalance;

    constructor() payable {
        owner=msg.sender;
        initialBalance = msg.value;
    }

    function getBalance() public view  returns(uint){
        return  address(this).balance;
    }
}