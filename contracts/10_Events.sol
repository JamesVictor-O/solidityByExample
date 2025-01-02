// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract EventDrivenArchitecture{
    event TransferInitiated(
       address indexed from, address indexed to, uint256 value
    );

    event TransferConfirmed(
         address indexed from, address indexed to, uint256 value
    );


    mapping (bytes32=> bool) public  transferConfirmation;

    function initiateTransfer(address to, uint value) public{
        emit TransferInitiated(msg.sender, to, value); 
    }

    function confirmTransfer(bytes32 transferId) public{
        require(!transferConfirmation[transferId], "Transfer already confiremed");
        transferConfirmation[transferId]=true;
        emit TransferConfirmed(msg.sender, address(this), 0);
    }
}