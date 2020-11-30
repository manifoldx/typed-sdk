============
Introduction
============

.. image:: ../docs/images/SDKOverview.jpg

Wallets are individual "accounts" created by each Manifold Finance protocol user.
Each wallet can request for different operations, transfer ERC, send message, and etc.

Each wallet is required to be connected by a network provider to the protocol/server 
in order to run any protocol-related operations (e.g., transfer, check  balance, etc.).

Inside the protocol, it will pass through a verification process run by KYC before
any operation can be started. All wallets, tokens must run KYC once before they can be used 
in Manifold Finance protocol.