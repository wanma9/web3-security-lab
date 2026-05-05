// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UncheckedOverflow {
    uint256 public total;

    function add(uint256 value) external {
        unchecked {
            total += value;
        }
    }

    function subtract(uint256 value) external {
        unchecked {
            total -= value;
        }
    }
}
