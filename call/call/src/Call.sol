// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract Call {
    event Called();

    address public parent;

    constructor(address _parent) {
        parent = _parent;
    }

    function call() public {
        emit Called();
        Call(parent).call();
    }
}

contract CallFactory {
    address public lastCreated;

    function call() public {
        if (lastCreated == address(0)) {
            Call newCall = new Call(address(this));
            lastCreated = address(newCall);
        } else {
            Call newCall = new Call(lastCreated);
            lastCreated = address(newCall);
        }
    }
}
