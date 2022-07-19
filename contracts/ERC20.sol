// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./IERC20.sol";
import "./SafeMath.sol"; //libraries can not be inheritted
import "./Ownable.sol";
import "./Context.sol";

contract ERC20 is  IERC20 , Context , Ownable 
{
    using SafeMath for uint256;

    /**
    @dev returns balance
     */
    mapping (address => uint256) _balances;

    mapping (address => mapping (address => uint256)) _allowances;

    /**
    @dev total supply and tradable decimals
     */

     uint private _totalSupply;
     uint private _decimals; // => حداکثر اعشار قیمت ETH => 18

     /**
     @dev Tokens name and symbol => Bitcoin - BTC
      */

      string private _name;
      string private _symbol;

      /**
      @dev contains information about the token
       */

       constructor (string memory name_ , string memory symbol_ , uint totalSupply_ , uint decimals_)
       {
        _name = name_;
        _symbol = symbol_;
        _totalSupply = totalSupply_;
        _decimals = decimals_;
       }

       /**
       @dev view functions
        */

        function name () public view virtual returns (string memory)
        {
            return _name;
        }

        function symbol () public view virtual returns (string memory)
        {
            return _symbol;
        }

        function totalSupply () public view virtual override returns (uint)
        {
            return _totalSupply;
        }

        function decimals () public view returns (uint)
        {
            return _decimals;
        }

        function balanceOf (address account) public view virtual override returns (uint256)
        {
            return _balances[account];
        }

        /**
        @dev makes sure that from and to addresses are not contract addresses 
        sets the balance of the sender and makes sure it has enough balance
        transfers amount from from to to address and sets the new balances
        Emits Transfer Event
         */

        function _transfer (address to , address from , uint256 amount) internal virtual 
        {
            require(from != address(0), "ERC20 : transfer from the zero address");
            require(to != address(0), "ERC20: transfer to the zero address" );

            uint256 fromBalance = _balances[from];
            require(fromBalance >= amount , "ERC20 : Insufficient balance");

            _balances[from] = _balances[from].sub(amount);
            _balances[to] = _balances[to].add(amount);

            emit Transfer (from, to , amount);
        }

        /**
        @dev makes sure both owner and spender are not zero addresses
        sets the allowance for spender from owner to have amount
        Emits approval event
         */

        function _approve (address owner , address spender , uint256 amount) internal virtual 
        {
            require(owner != address(0),"ERC20 : Owner Address not approved (Zero Address)");
            require(spender != address(0) , "ERC20 : Spender Address not approved (Zero Address)");

            _allowances[owner][spender] = amount;

            emit approval(owner, spender, amount);
        }

        /**
        @dev functions that need override
         */

        function transfer (address to, uint256 amount) public virtual override returns (bool)
          {
            address from = _msgSender();
            _transfer(to , from , amount);

            return true;
          }



        function allowance (address owner , address spender) public view virtual override returns (uint256)
        {
            return _allowances[owner][spender];
        }



        function transferFrom (address from , address to , uint256 amount) public virtual override returns (bool)
        {
            address spender = _msgSender();
            require(amount <= _allowances[from][spender]);
            _allowances[from][spender] = _allowances[from][spender].sub(amount);
            _transfer(from , to , amount);

            return true;
        }



        function approve (address spender , uint256 amount) public virtual override returns (bool)
        {
            address owner = _msgSender();
            _approve(owner , spender , amount);

            return true;
        }


} 