// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract ReceiveEthers{

    // function to receive Ether, msg.data must be empty
    receive() external payable { }

    // fallback function is called when msg.sender is not empty
    // fallback() external payable{}

    function getBalance() public  payable  returns(uint){
         return  address(this).balance;
    }
}


contract SendEther{
     function sendViaTransfer(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    function sendViaSend(address payable _to) public payable {
        bool sent=_to.send(msg.value);

        require(sent, "Failed to send Ether");
    }

    function sendVaiCall(address payable  _to) public  payable {
        (bool sent,)=_to.call{value: msg.value}("");

        require(sent, "Failed to send Ether");
    }
}

contract Fallback{
     event Log(string func, uint gas);

    fallback() external payable {
        // send / transfer (forwards 2300 gas to this fallback function)
        //  call (forwards all of the gass)
         emit  Log("fallback", gasleft());

     }

     receive() external payable {
        emit Log("receive", gasleft());
      }

      function getBalance() public view returns(uint){
         return  address(this).balance;
      }
}

contract SendToFallback{
    function transferToFallback(address payable  _to) public  payable {
        _to.transfer(msg.value);
    }

    function callFallback(address payable _to) public payable {
        (bool sent,)=_to.call{value: msg.value}("");
        require(sent, "Faild to send");
    }
}






contract Reciver{
     event Recevied(address caller, uint amount, string message);
    fallback() external payable { 
        emit Recevied(msg.sender, msg.value, "payment for nfts");
    }
   
   receive() external payable { }


    function foo(string memory _message, uint _x) public payable  returns(uint){
        emit  Recevied(msg.sender, msg.value, _message);

        return  _x + 1;
    }
}


contract Caller{
    event Response(bool success, bytes data);

   function testCallFoo(address payable _addr) public payable {
        (bool success, bytes memory data)=_addr.call{value:msg.value, gas:5000}(
             abi.encodeWithSignature("foo(string,uint256)", "call foo", 123)
        );
         emit Response(success, data);
   }
   
  
}
 


 