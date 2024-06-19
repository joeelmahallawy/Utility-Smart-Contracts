This contract allows users to lock up LP tokens. Each deployed contract will have an assigned LP token that it will lock, and it can only lock that LP token and no other.

## Deploying

When you are deploying this contract, you will specify the address of the LP token that this contract will be locking.

## Locking

You will call the `lockTokens` function with the parameters (uint256 \_amount, uint256 \_unlockTime). \_amount will be the amount of tokens the user wants to lock up. \_unlockTime is a timestamp in the format of SECONDS (not milliseconds).
