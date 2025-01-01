// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract FunctionModifier{
    address public owner;
    uint public x=10;
    bool public locked;

    constructor(){
        owner=msg.sender;
    }
    
   modifier  onlyOwner(){
     require(msg.sender == owner,"Not owner");
     _;
   }

   modifier  validateAddress(address _address){
    require(_address != address(0), "Address Not valid");
    _;
   }
   
   function changeOwner(address _newOwner) public  onlyOwner validateAddress(_newOwner){
       owner=_newOwner;
   }
   
   modifier  noReentrancy(){
      require(!locked, "No reentrancy");
      locked=true;
      _;

      locked= false;
   }

   function decrement(uint256 i) public noReentrancy{
     x-=i;
     if(i > 1){
        decrement(i-1);
     }
   }
}