// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
  address public minter;

  event MinterChanged(address indexed from, address to);

  constructor() public payable ERC20("dbank currency", "DCB") {
     minter = msg.sender;
  }

  modifier mustBeOwner {
    require(msg.sender == minter, 'need to be owner for this operation');
    _;
  }

  function passMinterRole(address dBank) public mustBeOwner returns (bool) {
    minter = dBank;

    emit MinterChanged(msg.sender, dBank);
    return true;
  }

  function mint(address account, uint256 amount) public mustBeOwner {
		_mint(account, amount);
	}
}
