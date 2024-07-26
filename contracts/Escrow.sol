//SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "./Supplystruct.sol";

contract Escrow{

  mapping (uint256 => escrowInfo) public escrows;

  //Event
  event deposited(uint256 orderId, address buyer, uint256 amount);
  event Released(uint256 orderId, address buyer, uint256 amount);

  // Deposit function
  function depositEscrow(uint256 _orderId, address _buyer, uint256 _amount)
         internal payable {
         require(_amount > 0, "value must be greater than zero");
         require(escrows[_order].amount == 0, "escrow already exists");
         escrows[_orderId] = escrowInfo(_buyer, _amount, false);

         emit deposited(_orderId, _buyer, _amount);
   }

  function ReleasedEscrow(uint256 _orderId, address payable _seller)
           internal {
           escrowInfo storage escrow = escrows[_orderId];
           require(!escrow.released, "Payment has already been made");
           require(escrow.amount > 0, "No funds to release");

            escrow.released= true;
           _seller.transfer(escrow.amount);

           emit Released(orderId, escrow.buyer, escrow.amount);
  }


}