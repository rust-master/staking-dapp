pragma solidity ^0.8.0;

import "./ERC20/ERC20.sol";

contract WrappedBitcoin is ERC20 {
  constructor() ERC20('WrappedBitcoin', 'WBTC') {
    _mint(msg.sender, 5000 * 10**18);
  }
}