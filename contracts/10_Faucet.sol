// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Faucet{
    receive() external payable { }

    function withDraw(uint _withdrawAmount) public payable  {
        require(_withdrawAmount <= 100000000000000000, "Cant't give out more than 0.1 ethers");
        address payable reciver=payable (msg.sender);
        reciver.transfer(_withdrawAmount);
    }
}