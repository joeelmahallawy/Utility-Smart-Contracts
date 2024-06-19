This contract will send different amounts of ERC20 tokens to according addresses (relative to position in array passed in). In other words, you can specify exactly how many ERC20 tokens each wallet will receive.

e.g. sendBatch([0x01, 0x02], [1, 6]) --> address 0x01 will receive 1 ERC20 token and address 0x02 will receive 6
