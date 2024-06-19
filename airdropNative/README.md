This contract will send a fixed amount of native tokens to a bunch of addresses that are passed in. In other words, you cannot specify how much each wallet will receive, you specify one amount and that same amount will be sent to each wallet.

e.g. airdrop([0x1,0x2], 0.5) will send 0.5 WEI to both wallets, 0x1 and 0x2
