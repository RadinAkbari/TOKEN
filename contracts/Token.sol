// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./ERC20.sol";

contract Radin is ERC20
{
    constructor () ERC20 ("radin" , "RAD" , 100000 * 1e5 , 5) {
        _balances[_msgSender()] = 100000 * 1e5;
}
}