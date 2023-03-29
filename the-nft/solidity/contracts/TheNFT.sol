// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract TheNFT is ERC721, Ownable {
    uint256 public tokenSupply;
    string public baseUrl;

    constructor() ERC721("TheNFT", "NFT") {}

    function setBaseUrl(string memory url) external onlyOwner {
        baseUrl = url;
    }

    function mint() public {
        _safeMint(msg.sender, ++tokenSupply);
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_exists(tokenId), "not exists");
        return string.concat(
            'data:application/json;utf8,',
            '{',
            '"name":"#', Strings.toString(tokenId), '",',
            '"description":"The NFT",',
            '"image":"', baseUrl, Strings.toString(tokenId), '"',
            '}'
        );
    }

    function dataTextPlain(uint256 tokenId) public pure returns (string memory) {
        return string.concat(
            'data:text/plain,%23',
            Strings.toString(tokenId)
        );
    }

    function dataTextHtml(uint256 tokenId) public pure returns (string memory) {
        return string.concat(
            'data:text/html,%3C%21DOCTYPE%20html%3E%3Chtml%3E%3Cdiv%20style%3D%22display%3A%20flex%3B%20justify-content%3A%20center%3B%20align-items%3A%20center%3B%20height%3A%20100vh%3B%22%3E%3Ch1%3E%23',
            Strings.toString(tokenId),
            '%3C%2Fh1%3E%3C%2Fdiv%3E%3C%2Fhtml%3E'
        );
    }

    function dataImageSvg(uint256 tokenId) public pure returns (string memory) {
        return string.concat(
            'data:image/svg+xml;charset=utf8,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%20100%20100%22%3E%0D%0A%3Crect%20x%3D%220%22%20y%3D%220%22%20width%3D%22100%22%20height%3D%22100%22%20fill%3D%22%23000000%22%20%2F%3E%0D%0A%3Ctext%20x%3D%2250%25%22%20y%3D%2250%25%22%20text-anchor%3D%22middle%22%20dominant-baseline%3D%22central%22%20fill%3D%22%23ffffff%22%3E%0D%0A%23',
            Strings.toString(tokenId),
            '%0D%0A%3C%2Ftext%3E%3C%2Fsvg%3E%0D%0A'
        );
    }
}
