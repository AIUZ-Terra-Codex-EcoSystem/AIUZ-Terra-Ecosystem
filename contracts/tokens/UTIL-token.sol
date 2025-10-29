// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title UTIL Token
 * @dev Terra Ecosystem Utility Token
 * 
 * Author: Abdurashid Abdukarimov
 * License: MIT
 */

contract UTILToken {
    string public constant name = "Terra Utility Token";
    string public constant symbol = "UTIL";
    uint8 public constant decimals = 18;
    uint256 public totalSupply;
    uint256 public maxSupply = 1000000000 * 10**18; // 1 billion
    
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;
    
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Burn(uint256 amount);
    
    constructor() {
        totalSupply = 400000000 * 10**18; // Initial 400M
        balanceOf[msg.sender] = totalSupply;
    }
    
    function transfer(address to, uint256 value) public returns (bool) {
        require(balanceOf[msg.sender] >= value, "Insufficient balance");
        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }
    
    function approve(address spender, uint256 value) public returns (bool) {
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }
    
    function burn(uint256 amount) public {
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Burn(amount);
    }
}
