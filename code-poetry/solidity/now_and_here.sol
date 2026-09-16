pragma solidity ^0.8.0;

contract NowAndHere {
    function now_and_here() public view returns (uint256, uint256) {
        return (block.timestamp, block.number);
    }
}
