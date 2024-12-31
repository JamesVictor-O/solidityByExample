// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract NftSeller{
    uint public NftPrice;
    bool public isSold;

    constructor(uint _price){
        isSold=false;
         NftPrice=_price;
    }

    function checkoutNft() public view returns(bool){
       return isSold;
    }

    function buyNft(uint _price)  public{
        require(_price >= NftPrice, "insufficient amount");
        isSold = true;
    }
}