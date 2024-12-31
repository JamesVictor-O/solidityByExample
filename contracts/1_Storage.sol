// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Function{
    function returnmany() public pure returns(uint16,bool,uint){
        return (1,true,2);
    }
    function namedValuse() public pure returns(uint x, bool b, uint y){
        return(x=2,b=true,y=3);
    }

    function destructuringAssignments() 
    public 
    pure 
    returns(uint, bool, uint, uint, uint)
    {
      (uint i, bool b , uint j)=returnmany();

      (uint x,,uint y)=(4,5,6);

      return (i, b, j,x,y);


    }
}