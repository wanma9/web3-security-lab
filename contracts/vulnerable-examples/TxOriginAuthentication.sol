// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TxOriginVulnerable {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function withdrawAll() external {
        require(tx.origin == owner, "Not owner");

        (bool success, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(success, "Transfer failed");
    }

    receive() external payable {}
}
