pragma solidity ^0.8.0;

contract Domino {
    address next;

    function place(address n) public {
        next = n;
    }

    function topple() public {
        if (next != address(0)) {
            Domino(next).topple();
        }
        selfdestruct(payable(msg.sender));
    }
}
