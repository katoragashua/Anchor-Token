// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IERC20 {
    
    function totalSupply() external view returns(uint);
    function balanceOf(address account) external view returns(uint);
    function transfer(address recipient, uint amount) external returns(bool);
   
    event Transfer(address indexed from, address indexed to, uint amount);
}

contract AnchorToken is IERC20 {
    address public owner;
    uint public override totalSupply;
    mapping(address => uint) public override balanceOf;
    string public name = "Anchor";
    string public symbol = "ANKT";
    uint8 public decimals = 18;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can mint tokens");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function transfer(address recipient, uint amount) external override returns (bool) {
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function mint(uint amount) external onlyOwner {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    function burn(uint amount) external {
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }

}