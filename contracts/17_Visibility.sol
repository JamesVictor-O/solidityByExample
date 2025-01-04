// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Base{
    // private contract can only be called inside this contract
    function privateFun() private pure returns(string memory) {
        return "private function called";
    }

    function testPrivateFunc() public pure returns( string memory){
        return privateFun();
    }
    
    // internal function can be called inside this contract
    // and inside contract that inherit this contract.
    function internalFunc() internal pure returns(string memory){
        return "internal function called";
    }

    function testInternalFunction() public pure virtual returns(string memory){
        return internalFunc();
    }

    //  public functions can be called 
    //  - inside this contract
    //  - inside contract that inherit this contract
    //  - by other contracts and account
    function publicFunc() public pure returns(string memory){
        return "public function called";
    }

    // External function can only be called 
    // by other contracts and accounts

    function externalFunc() external pure returns(string memory){
        return "external function called";
    }
    

    string private privateVar="my private variable";
    string internal internalVar="my internal variable";
    string public publicVar="my public variable" ;
}

contract Child is Base{
    function testInternalFunction() public pure override returns(string memory){
        return internalFunc();
    }
}