//pragma solidity ^0.4.19;
pragma solidity ^0.8.6;
//SPDX-License-Identifier: UNLICENSED

contract owned {
    address payable owner;

    constructor(){
        owner = payable(msg.sender);
    }

    modifier onlyOwner {
        require(msg.sender == owner);
            _;
    }
}

// Our first contract is a faucet!
contract Faucet is owned{

   // Give out ether to anyone who asks
   function withdraw(uint withdraw_amount) public {

       // Limit withdrawal amount
       require(withdraw_amount <= 100000000000000000);
       
        // Send the amount to the address that requested it
        payable(msg.sender).transfer(withdraw_amount);
    }

    // Accept any incoming amount
    fallback () external payable {}

    receive() external payable {
            // React to receiving ether
        }

    // Destructor
    function destroy() external onlyOwner {
        selfdestruct(owner);
    }

}
