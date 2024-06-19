// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);
}

contract LPTokenLock {
    address public owner;
    IERC20 public lpToken;

    struct LockedToken {
        uint256 amount;
        uint256 unlockTime;
    }

    mapping(address => LockedToken[]) public lockedTokens;

    event TokensLocked(
        address indexed user,
        uint256 amount,
        uint256 unlockTime
    );
    event TokensUnlocked(address indexed user, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    constructor(address _lpToken) {
        owner = msg.sender;
        lpToken = IERC20(_lpToken);
    }

    function lockTokens(uint256 _amount, uint256 _unlockTime) external {
        require(_amount > 0, "Amount must be greater than 0");
        require(
            _unlockTime > block.timestamp,
            "Unlock time must be in the future"
        );

        lpToken.transferFrom(msg.sender, address(this), _amount);

        lockedTokens[msg.sender].push(LockedToken(_amount, _unlockTime));

        emit TokensLocked(msg.sender, _amount, _unlockTime);
    }

    function unlockTokens() external {
        uint256 unlockAmount = 0;
        uint i = 0;
        while (i < lockedTokens[msg.sender].length) {
            if (block.timestamp >= lockedTokens[msg.sender][i].unlockTime) {
                unlockAmount += lockedTokens[msg.sender][i].amount;

                // Remove unlocked item by swapping it with the last element and then deleting the last element
                lockedTokens[msg.sender][i] = lockedTokens[msg.sender][
                    lockedTokens[msg.sender].length - 1
                ];
                lockedTokens[msg.sender].pop();
            } else {
                i++;
            }
        }

        require(unlockAmount > 0, "No tokens to unlock");

        lpToken.transfer(msg.sender, unlockAmount);

        emit TokensUnlocked(msg.sender, unlockAmount);
    }

    // Optional: Function to retrieve locked tokens information by user
    function getLockedTokens(
        address _user
    ) external view returns (LockedToken[] memory) {
        return lockedTokens[_user];
    }

    // Optional: Update LP Token address (Owner Only)
    function updateLPTokenAddress(address _newLPToken) external onlyOwner {
        lpToken = IERC20(_newLPToken);
    }
}
