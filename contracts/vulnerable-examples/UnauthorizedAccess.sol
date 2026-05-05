// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UnauthorizedAccess {
    address public owner;
    mapping(address => uint256) public allowances;

    constructor() {
        owner = msg.sender;
    }

    function setAllowance(address user, uint256 amount) external {
        // Falta control de acceso: cualquier usuario puede cambiar la asignación
        allowances[user] = amount;
    }

    function withdraw(uint256 amount) external {
        require(allowances[msg.sender] >= amount, "Allowance exceeded");
        allowances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    receive() external payable {}
}
