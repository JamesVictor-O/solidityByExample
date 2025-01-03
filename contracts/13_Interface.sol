// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;
contract Counter{
    uint256 public count;

    function increment() external {
        count += 1;
    }
}

interface ICounter {
    function count() external view returns (uint256);

    function increment() external;
}

contract MyContract{
    function incrementCounter(address _counter) external{
        ICounter(_counter).increment();
    }
}


interface ICalculator {
    function add(uint a, uint b) external pure returns(uint);
    function subtract(uint a, uint b) external pure returns(uint);
}
