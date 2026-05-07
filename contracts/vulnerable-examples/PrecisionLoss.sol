// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PrecisionLoss {
    uint256 public totalTokens = 100;
    uint256 public totalUsers = 3;

    function tokensPerUser() external view returns (uint256) {
        // Perdida de precision por division entera
        return totalTokens / totalUsers;
    }
}