// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract TokenSales{
    uint public totalSupply;
    uint public totalRaised;
    mapping (address => uint) public balances;
    address[] public addressList;
    uint public maxPurchaseLimit;

        //    set the total number of token supply, maximum purches limit for each address.
     constructor(uint _totalSupply,uint _totalAmountRaised){
           totalSupply=_totalSupply;
           totalRaised=_totalAmountRaised;
           maxPurchaseLimit= totalSupply/4;
     }
     

     
    function buyToken() public payable {

        // must send a token in other to be able to buy a token
       require(msg.value > 0, "you must send ethers to buy token");
       

    //   ensuring that an address does not buy more than the maximum purches limit
       require(
        balances[msg.sender] + msg.value <= maxPurchaseLimit,
         "You cannot buy more than 25% of the total supply"
         );
    
    // can only buy if token is in supply
        require(
            totalSupply > 0,
            "out of token supply"
        );

       uint amount= msg.value;
     
       if(balances[msg.sender]==0){
         addressList.push(msg.sender);
       }

       balances[msg.sender] += amount;
       totalSupply -= amount;
       totalRaised += amount;
    }


}