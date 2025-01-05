// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract B{
     uint public num;
     address public sender;
     uint public value;
     
    //  constructor () payable  {}
    receive() external payable { }

     function setVars(uint _num) public payable {
          num=_num;
          sender =msg.sender;
          value=msg.value; 
     }
}

contract A {
    uint public num;
     address public sender;
     uint public value;
    function setVar(address _contract, uint _num) public payable {
        (bool success,)= _contract.delegatecall(
        abi.encodeWithSignature("setVars(uint256)", _num)
    );

        require(success, "DelegateCall failed");
    }
}

contract ChildContract{
    uint public number;

    function setNumber(uint _number) public {
        number = _number;
    }
}


contract ParentContract{
    uint public number;

     function useDelegateCall(address _logicContract, uint _newNumber) public{
           (bool success,)=_logicContract.delegatecall(
            abi.encodeWithSignature("setNumber(uint256)", _newNumber)
           );

           require(success, "Delegatecall failed");
     }
}