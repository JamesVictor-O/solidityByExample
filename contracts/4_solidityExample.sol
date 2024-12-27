// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract SolidityExample{
    uint count;
    address public sender;
    uint public amount; 
    constructor(){
        count = 0;
    }

    function get() public view returns (uint){
        return  count;
    }

    function increment()public{
         count += 1;
    }

    function decrement()public{
        require(count >= 1, "can not decrease, count is less than one");
        count -= 1;
    }

    function doSomething() public payable returns (uint) {
       uint timestamp;
       amount+=msg.value;
       timestamp=block.timestamp;
       sender=msg.sender;


       return  timestamp;
    }
}