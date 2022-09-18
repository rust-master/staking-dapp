pragma solidity ^0.8.0;

import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract UsdCoin is ERC20 {
  constructor() ERC20('UsdCoin', 'USDC') {
    _mint(msg.sender, 5000 * 10**18);
  }
}