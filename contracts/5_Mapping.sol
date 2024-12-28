// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Mapping{
    mapping(string => address) public myMap;
    string[] public myArray;

    function get(string memory _name)public view returns(address){
         return myMap[_name];
    }
    function set(address _addr, string memory _i)public{
        myMap[_i]=_addr;
    }


    // array
    function getArray() public view returns (string[] memory){
         return myArray;
    }

    function push(string memory _name) public{
         myArray.push(_name);
    }

}