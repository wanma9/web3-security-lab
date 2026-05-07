// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UnsafeExternalCall {
    address public target;

    constructor(address _target) {
        target = _target;
    }

    function execute(bytes calldata data) external {
        // Llamada externa insegura
        (bool success, ) = target.call(data);

        require(success, "Call failed");
    }
}