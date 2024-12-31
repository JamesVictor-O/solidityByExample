// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Enums{
    enum Status{
        Pending,
        Shipped,
        Accepted,
        Rejected,
        Canceled
    }
    uint public user;
    type UserID is uint256;
    type Balance is uint256;

    Status public status;

    function get() public view returns(Status){
        return status;
    }

    function set(Status _status) public{
        status = _status;
    }
    function cancel()public{
        status = Status.Canceled;
    }
    function reset()public{
        delete status;
    }
    function setUserID(UserID _id)public returns (uint){
        user = UserID.unwrap(_id);
        return  user;
    }
}