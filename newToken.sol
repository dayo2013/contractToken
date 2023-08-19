// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;
// Name of the contract and visibility pass

contract Token {
    string public name;
    uint256 public  totalsupply;

    // mapping address to variable allowlist
    mapping(address => bool) public allowlist;
    //mapping address to balance

    mapping(address => uint256) public balanceOf;
    // constructor is use to update  the state of the Evm after deployment

    constructor(string memory _name, uint256 _totalsupply){
        name = _name;
        totalsupply = _totalsupply;
        balanceOf[msg.sender] = _totalsupply;
    }
    // to add extra security layer to the contract

    modifier  onlyAllowlisted(){
        require(allowlist[msg.sender],"address not allowlisted");
        _;
    }
//adding extra security layer if the above  condition is true
    function addToAllowlist(address _address) public {
        allowlist[_address] = true;
    }
//adding extra security layer if the above condition is false
    function removeFromAllowList(address _address)public {
        allowlist[_address] = false;
    }
    // function that help in transfer
    function transfer(address _to, uint256 _amount)public onlyAllowlisted{
        require(_amount <= balanceOf[msg.sender],"insufficient balance");
        require(_to != address(0),"invalid address");
        balanceOf[msg.sender] -= _amount;
        balanceOf[_to] += _amount;
    } 



}