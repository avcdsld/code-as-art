pragma solidity ^0.8.0;

contract NowAndHere {
    function now_and_here() public view returns (uint256, address) {
        return (block.number, address(this));
    }
}
