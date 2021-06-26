//pragma solidity ^0.4.19;
pragma solidity ^0.8.6;
//SPDX-License-Identifier: UNLICENSED

contract owned {
    address payable owner;

    constructor(){
        owner = payable(msg.sender);
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Only the contract owner can call this function");
            _;
    }
}

contract mortal is owned{
    // Destructor
    function destroy() external onlyOwner {
        selfdestruct(owner);
    }
}

// Our first contract is a faucet!
contract Faucet is mortal{

    event Withdrawal(address indexed to, uint amount);
    event Deposit(address indexed from, uint amount);

   // Give out ether to anyone who asks
   function withdraw(uint withdraw_amount) public {

       // Limit withdrawal amount
       require(withdraw_amount <= 0.1 ether);
            // Checking for faucet founds
            require(address(this).balance >= withdraw_amount, "Insufficient balance in faucet for withdrawal request");
                // Send the amount to the address that requested it
                payable(msg.sender).transfer(withdraw_amount);
                // Printing event into transacition log
                emit Withdrawal(msg.sender, withdraw_amount);
        }

    // Accept any incoming amount
    fallback () external payable {}

    receive() external payable {
            // React to receiving ether
            emit Deposit(msg.sender, msg.value);
        }

}
