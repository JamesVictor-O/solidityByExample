// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;
contract Callee{
    uint public x;

    function setX(uint _x) public {
        x=_x;
    }

    function getX( ) public view returns(uint){
       return x;
    }
}


contract Caller{
    uint public valueFromB;

    // function callSetX(address _contractB, uint _x) public {
    //     B b=B(_contractB);
    //     b.setX(_x);
    // }

    // function callGetX(address _contractB) public view returns(uint){
    //     B b=B(_contract);
    //     return b.getX();
    // }
}