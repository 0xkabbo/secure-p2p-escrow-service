// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title Escrow
 * @dev Simple trustless escrow for P2P transactions.
 */
contract Escrow {
    enum State { AWAITING_PAYMENT, AWAITING_DELIVERY, CLOSED, DISPUTED }
    
    address public seller;
    address public buyer;
    address public arbiter;
    uint256 public amount;
    State public currentState;

    modifier onlyBuyer() {
        require(msg.sender == buyer, "Only buyer can call this");
        _;
    }

    modifier onlySeller() {
        require(msg.sender == seller, "Only seller can call this");
        _;
    }

    modifier onlyArbiter() {
        require(msg.sender == arbiter, "Only arbiter can call this");
        _;
    }

    constructor(address _buyer, address _arbiter) payable {
        seller = msg.sender;
        buyer = _buyer;
        arbiter = _arbiter;
        amount = msg.value;
        currentState = State.AWAITING_DELIVERY;
    }

    function confirmDelivery() external onlyBuyer {
        require(currentState == State.AWAITING_DELIVERY, "Cannot confirm delivery now");
        currentState = State.CLOSED;
        payable(seller).transfer(address(this).balance);
    }

    function initiateDispute() external {
        require(msg.sender == buyer || msg.sender == seller, "Only parties involved can dispute");
        require(currentState == State.AWAITING_DELIVERY, "Cannot dispute now");
        currentState = State.DISPUTED;
    }

    function resolveDispute(address _winner) external onlyArbiter {
        require(currentState == State.DISPUTED, "Not in dispute");
        require(_winner == seller || _winner == buyer, "Winner must be buyer or seller");
        
        currentState = State.CLOSED;
        payable(_winner).transfer(address(this).balance);
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
