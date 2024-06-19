// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Airdrop {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    receive() external payable {}

    function airdrop(
        address[] calldata recipients,
        uint256 amount
    ) external payable onlyOwner {
        for (uint i = 0; i < recipients.length; i++) {
            payable(recipients[i]).transfer(amount);
        }
    }

    function withdraw() external onlyOwner {
        payable(owner).transfer(address(this).balance);
    }
}
