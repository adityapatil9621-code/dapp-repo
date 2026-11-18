
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract msgec {

    uint public a;

    function add(uint e, uint b) public {
        uint addq = e + b;
        a = addq;
    }
}
