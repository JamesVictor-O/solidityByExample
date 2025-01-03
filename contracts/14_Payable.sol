// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract CrowdFunding{
    address payable owner;
    uint public goal;
    uint public totalFunds=0;
    uint public  deadline;

    constructor(uint _goal, uint _duration){
        owner=payable (msg.sender);
        goal= _goal;
        deadline = block.timestamp * _duration;
    }

    mapping (address => uint ) public contributors;

    modifier  notOwner(){
        require(msg.sender != owner, "Owner of the account can't donate");
        _;
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "Not Owner, Only Owner Can withdraw funds");
        require(address(this).balance > 0, "Insufficient funds");
        require(block.timestamp > deadline, "Campaign not over yet");
        require(totalFunds >= goal, "goal not yet met");
        _;  
    }

    function contribute() public payable notOwner {
        require(block.timestamp < deadline, "Campaign has ended");
        require(msg.value > 0, "Donation must be greater than zero");
         
         contributors[msg.sender] += msg.value;
         totalFunds += msg.value;
    }

    function withdrawFunds() public payable onlyOwner {
        (bool sucsses,)= owner.call{value: address(this).balance}("");
        require(sucsses, "Transfer failed");
    }

    function getbalance() public view returns (uint){
         return  address(this).balance;
    }
}