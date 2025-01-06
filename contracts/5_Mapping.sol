// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Mapping{
   // mapping in solidity is define using the key value type.
   //mapping(keyType => valueType) public mappingName;
   // example mapping from address to uint,

   mapping (address => uint256) public myMap;
    
   function get(address _addr) public view returns(uint){

     // mapping always returns a value,whether set or no
     // if the value was never set it returns a default value. 
      return  myMap[_addr];
   }

   function set(address _address) public payable  {
     //    updates the value at this address
        myMap[_address] += msg.value;
   }

   function remove(address _addr) public{
      delete  myMap[_addr];
   }
}

contract NestedMapping{
     // nested mapping
     mapping (address => mapping (uint => bool)) public nested;
     
     function setLocker(address _person, uint _lockerNumber, bool _isLocked) public{
          nested[_person][_lockerNumber]= _isLocked;
     }

     function isLockerLocked(address _person,uint _lockerNumber) public view returns(bool){
          return  nested[_person][_lockerNumber];
     }
}