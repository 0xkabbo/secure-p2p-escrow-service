# Secure P2P Escrow Service

This repository provides a robust smart contract for handling peer-to-peer cryptocurrency transactions without a centralized intermediary. It is designed for users who need to swap assets safely, ensuring that funds are only released when both parties fulfill their obligations.

## Features
- **Escrow Locking**: Seller locks funds in the contract; funds are only released upon buyer confirmation or arbiter intervention.
- **Role-Based Access**: Clearly defined roles for Buyer, Seller, and an optional Arbiter.
- **Refund Logic**: Built-in timeout mechanism allowing sellers to reclaim funds if a buyer goes inactive.
- **Security**: Protection against re-entrancy and unauthorized state changes.



## Workflow
1. **Initiate**: Seller creates an escrow by depositing funds and naming a Buyer.
2. **Confirm**: Buyer confirms receipt of the off-chain item/service.
3. **Release**: Funds are automatically transferred to the Seller.
4. **Dispute**: If things go wrong, an Arbiter can decide the outcome.

## License
MIT
