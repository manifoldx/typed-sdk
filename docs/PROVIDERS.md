# Network Provider

A network provider is an abstracts connection to the blockchain, for
issuing queries and sending signed state-changing transactions.

The _JsonRpcProvider_ allows you to connect to blockchain nodes that you
control or have access to, including mainnet, testnets, or localnets.

---

## Connecting to Blockchain

There are several methods to connect to the blockchain network provider.
If you are not running your own local blockchain node, it is recommended
that you use the `getDefaultProvider()` method.

<sup>manifold</sup> . getDefaultProvider( \[ network = "localnet" \] )   <span class="title-ref">=&gt; Provider</span>  
This creates a FallbackProvider backed by multiple backends.

This is the **recommended** method of connecting to the blockchain
network if you are not running your own blockchain node.

<!-- -->

    let networkProvider = manifold.getDefaultProvider("localnet");

### JsonRpcProvider <sup>( inherits from Provider )</sup>

<div id="provider-jsonrpc-properties">

<sup>prototype</sup> . connection  
An object describing the connection of the JSON-RPC endpoint with the
following properties:

- **url:** _string_ url (the JSON-RPC URL)
- **timeout:** _int_ RPC request timeout in milliseconds (default:
  120,000 ms)
- **user:** _string_ username (a username to be used for basic
  authentication, optional)
- **password:** _string_ password ( a password to use for basic
  authentication, optional)
- **allowInsecure:** _boolean_ allow basic authentication over an
  insecure HTTP network (default: false)

new <sup>manifold . providers</sup> . JsonRpcProvider( \[ urlOrInfo <sup>= "http://localhost:26657"</sup> \] \[ , network \] )  
Connect to the [JSON-RPC
API](https://github.com/ethereum/wiki/wiki/JSON-RPC) URL _urlOrInfo_ of
a blockchain node.

The _urlOrInfo_ may also be specified as an object with the following
properties:

- **url:** _string_ url (the JSON-RPC URL, **required**)
- **timeout:** _int_ RPC request timeout in milliseconds (default:
  60,000 ms)
- **user:** _string_ username (a username to be used for basic
  authentication, optional)
- **password:** _string_ password (a password to use for basic
  authentication, optional)
- **allowInsecure:** _boolean_ allow basic authentication over an
  insecure HTTP network (default: false)

**See also:** JSON-RPC provider-specific
`Properties <provider-jsonrpc-properties>` and
`Operations <provider-jsonrpc-extra>`

</div>

    // You can use any standard network name
    //  - "homestead"
    //  - "testnet"

    let networkProvider = manifold.getDefaultProvider('localnet');

    let provider = new manifold.providers.JsonRpcProvider({
        url: "https://x.x.x.x",
        timeout: 60000
    }, "manifold");

    let provider = new manifold.providers.JsonRpcProvider({
        url: "https://x.x.x.x",
        timeout: 60000
    }, {
        chainId: "awesome",
        name: "awesome"
    });

---

## Properties

Not all properties are mutable unless otherwise specified, and will
reflect their default values if left unspecified.

### Provider Variables

<sup>prototype</sup> . blockNumber  
Returns the most recent block number (block height) this provider has
seen and has triggered events for. If no block has been seen, this is
_null_.

_data type: integer_

<sup>prototype</sup> . polling  
_mutable_

If the provider is currently polling because it is actively watching for
events. This may be set to enable/disable polling temporarily or
disabled permanently to allow a node process to exit.

_data type: boolean_

<sup>prototype</sup> . pollingInterval  
_mutable_

The frequency (in milliseconds) that the provider is polling. The
default interval is 4 seconds.

This may make sense to lower for polling a local node. When polling
external nodes, setting this too low may result in the service blocking
your IP address or otherwise throttling your API calls.

_data type: integer_

### Network

A network represents various properties of a network, such as mainnet,
testnet, or private networks.

<sup>prototype</sup> . getNetwork ( )   <span class="title-ref">=&gt; Promise&lt;Network&gt;</span>  
A `Promise <promise>` that resolves to a <span
class="title-ref">Network</span> object describing the connected network
and chain. A network has the following properties:

- _chainId_ --- the chain ID (network ID) of the connected network
- _name_ --- the name of the network (e.g., "testnet")

<!-- -->

    let network = manifold.providers.getNetwork('localnet');
    // {
    //    chainId: "manifold",
    //    name: "localnet"
    // }

    let network = {
        chainId: "localnet",
        name: "local"
    }

---

### Account

_A 'dummy' wallet is used below, there is not real user behind it._

<sup>prototype</sup> . getBalance ( `AddressOrName <addressOrName>` )   <span class="title-ref">=&gt; Promise&lt;BigNumber&gt;</span>  
Returns a `Promise <promise>` with the balance (as a
`BigNumber <bignumber>`) of `AddressOrName <addressOrName>`.

<!-- -->

    let address = "manifold1x7tp9tt7mu0jm6qdmljgntvzzp53lrtndr7h8x";

    provider.getBalance(address).then((balance) => {

        // balance is a BigNumber (in cin); format is as a string (in manifold)
        let manifoldString = manifold.utils.formatMxw(balance);

        console.log("Balance: " + manifoldString);
    });

    //expected result:
    //Balance: 0.0

<sup>prototype</sup> . getTransactionCount ( `AddressOrName <addressOrName>` )   <span class="title-ref">=&gt; Promise&lt;BigNumber&gt;</span>  
Returns a `Promise <promise>` with the number of sent transactions (as a
`BigNumber <bignumber>`) from `AddressOrName <addressOrName>`. This is
also the nonce required to send a new transaction.

<!-- -->

    let address = "manifold1x7tp9tt7mu0jm6qdmljgntvzzp53lrtndr7h8x";

    provider.getTransactionCount(address).then((nonce) => {
        console.log("Total Transactions Ever Sent: " + nonce.toString());
    });

    //expected result:
    //Total Transactions Ever Sent: 0

<sup>prototype</sup> . getAccountNumber ( `AddressOrName <addressOrName>` )   <span class="title-ref">=&gt; Promise&lt;BigNumber&gt;</span>  
Returns a `Promise <promise>` with the account number of wallet (as a
`BigNumber <bignumber>`) from `AddressOrName <addressOrName>`.

<!-- -->

    let address = "manifold1x7tp9tt7mu0jm6qdmljgntvzzp53lrtndr7h8x";

    provider.getAccountNumber(address).then((accountNumber) => {
        console.log("Account number: " + accountNumber.toString());
    });

    //expected result:
    //Account number:0

---

### Blockchain Status

<sup>prototype</sup> . getBlockNumber ( )   <span class="title-ref">=&gt; Promise&lt;number&gt;</span>  
Returns a `Promise <promise>` with the latest block number (as a
Number).

<!-- -->

    provider.getBlockNumber().then((blockNumber) => {
        console.log("Latest block number: " + blockNumber);
    });
    // expected result:
    // Latest block number: "*integer* latest block number"

<sup>prototype</sup> . getBlock ( blockHashOrBlockNumber )   <span class="title-ref">=&gt; Promise&lt;Block&gt;</span>  
Returns a `Promise <promise>` with the block at
_blockHashOrBlockNumber_. (See: `Block Responses <blockresponse>`)

<!-- -->

    // Block Number
    provider.getBlock(12345).then((block) => {
        console.log(block);
    });
    //expected result:
    //block response, click on the link above for more information

<sup>prototype</sup> . getTransactionReceipt ( transactionHash )   <span class="title-ref">=&gt; Promise&lt;TransactionReceipt&gt;</span>  
Returns a `Promise <promise>` with the transaction receipt with
_transactionHash_. (See: `Transaction Receipts <transaction-receipt>`)

<!-- -->

    let transactionHash = "0x434c7fe4c7c7068289f0d369e428b7a3bf3882c3253f2b7f9529c0985a1cb500"

    provider.getTransactionReceipt(transactionHash).then((receipt) => {
        console.log(receipt);
    });
    //expected result:
    //transaction receipt, click on the link above for more information

<sup>prototype</sup> . getTransactionFee ( route, transactionType, overrides, ... )   <span class="title-ref">=&gt; Promise&lt;TransactionFee&gt;</span>  
Returns a `Promise <promise>` that resolves to the estimated
_transaction fee_ structure.

The valid routes and transaction types are:

- **kyc** --- the route for kyc module

  - **kyc-whitelist** --- the whitelist transaction type
  - **kyc-revokeWhitelist** --- the revoke whitelist transaction
    type

- **bank** --- the route for bank module

  - **bank-send** --- the transfer MXW transaction type

- **token** --- the route for token module

  - **token-mintFungibleToken** --- the mint transaction type
  - **token-burnFungibleToken** --- the burn transaction type
  - **token-freeze** --- the freeze transaction type
  - **token-unfreeze** --- the unfreeze transaction type
  - **token-createFungibleToken** --- the create transaction type
  - **token-setFungibleTokenStatus** --- the set status transaction
    type

- **nameservice** --- the route for name service module
  - **nameservice-createAlias** --- the create transaction type
  - **nameservice-setAliasStatus** --- the set status transaction
    type

<div id="transaction-fee">

    {
        amount: [
            {
                // The denomination should be in cin
                denom: string,

                // The fee amount in cin
                amount: BigNumberish
            }
        ],
        // Reserved for future
        gas: BigNumberish
    }

</div>

    let value = utils.parseMxw("10").toString();
    provider.getTransactionFee("bank", "bank-send").then((fee) => {
        console.log("Fee:", fee);
    });

---

### Waiting for Transactions

<sup>prototype</sup> . waitForTransaction ( transactionHash )   <span class="title-ref">=&gt; Promise&lt;TransactionReceipt&gt;</span>  
Returns a `Promise <promise>` which resolves to the
`Transaction Receipt <transaction-receipt>` once _transactionHash_ is
validated.

<!-- -->

    provider.waitForTransaction(transactionHash).then((receipt) => {
        console.log('Transaction validated: ' + receipt.hash);
        console.log(receipt);
    });

    //expected result:
    //transaction receipt, click on the link above for more information

---

### Objects and Types

There are several common objects and types that are commonly used as
input parameters or return types for various provider calls.

---

#### Block Tag

A block tag is used to uniquely identify a block's position in the
blockchain:

a Number or `hex string <hexstring>`:  
Each block has a block number (e.g., `1202` or `"0x4b2"`).

"latest":  
The most recently validated block.

"pending":  
The block that is currently being validated.

---

### Provider-Specific Extra API Calls

<div id="provider-jsonrpc-extra">

**JsonRpcProvider**

</div>

<sup>prototype</sup> . send ( method , params )   <span class="title-ref">=&gt; Promise&lt;any&gt;</span>  
Sends the JSON-RPC _method_ with _params_. This is useful for calling
non-standard or less common JSON-RPC methods. A `Promise <promise>` is
returned which will resolve to the parsed JSON result.

<!-- -->

    //method parameter is based on vendor RPC API
    jsonRpcProvider.send('status', [ ]).then((result) => {
        console.log(result);
    });
    // expected result:
    // "status of the provider for this case"

---
