// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./ERC721.sol";
import "./Util.sol";

contract TheNFT_simple is ERC721 {
    string public name = "TheNFT";
    string public symbol = "NFT";
    uint256 totalSupply = 0;

    function mint() public {
        uint256 id = ++totalSupply;
        ownerOf[id] = msg.sender;
        balanceOf[msg.sender]++;
        emit Transfer(address(0), msg.sender, id);
    }

    function tokenURI(uint256 id) public pure returns (string memory) {
        return string.concat(
            'data:application/json,',
            '{',
            '"name":"The NFT',
            '"description":"TheNFT",',
            '"image":"data:text/plain,', Util.toString(id), '"',
            '}'
        );
    }
}
