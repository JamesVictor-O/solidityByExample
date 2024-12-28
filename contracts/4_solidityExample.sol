// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract SolidityExample{
    uint count;
    address public sender;
    uint public amount; 
    uint[] public donores=[2,3,5];
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

    // If/Else

    function foo(uint _value) public pure returns(uint){
           if(_value < 10){
              return  0;
           }else if(_value < 20){
             return 1;
           }else {
            return  2;
           }
    }

    function fooT(uint _value)public pure returns (uint){
          return  _value < 10 ? 0 : _value < 20 ? 1 : 2;
    }

    // loop

    // function shareAmount(uint _amountToBeShared) public view{
    //     for(uint i=0; i < _amountToBeShared; i++){
    //       donores[i]+2;
    //       _amountToBeShared -= 2;
    //     }
    // }
}