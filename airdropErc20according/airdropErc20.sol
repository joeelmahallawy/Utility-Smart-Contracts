// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

/**
 * @title Token
 * @dev Simpler version of ERC20 interface
 */
interface Token {
    function transferFrom(address sender, address to, uint amount) external;
    //   function transfer(address to, uint256 value) external returns (bool);
    //   function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);
    function approve(
        address _spender,
        uint256 _value
    ) external returns (bool success);
    //   event Transfer(address indexed from, address indexed to, uint256 value);
}

contract AirDrop {
    // This declares a state variable that would store the contract address
    Token public tokenInstance;
    address owner;

    /*
    constructor function to set token address
   */
    constructor(address _tokenAddress) {
        tokenInstance = Token(_tokenAddress);
        owner = msg.sender;
    }

    function sendBatch(
        address[] memory _recipients,
        uint[] memory _values
    ) public returns (bool) {
        require(msg.sender == owner);
        require(_recipients.length == _values.length);
        for (uint i = 0; i < _values.length; i++) {
            tokenInstance.transferFrom(msg.sender, _recipients[i], _values[i]);
        }
        return true;
    }

    function approve(_amount) external {
        tokenInstance.approve(address(this), _amount * 10 ** 18);
    }

    function transferEthToOwner() public {
        require(msg.sender == owner);
        payable(owner).transfer(address(this).balance);
    }

    function kill() public {
        require(msg.sender == owner);
        selfdestruct(payable(owner));
    }
}

// [0x01, 0x02, 0x03]
// [100, 150, 292]
