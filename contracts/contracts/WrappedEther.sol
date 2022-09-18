pragma solidity ^0.8.0;

import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract WrappedEther is ERC20 {
  constructor() ERC20('WrappedEther', 'WETH') {
    _mint(msg.sender, 5000 * 10**18);
  }
}