# `@manifold/sdk`

> a well-typed SDK

## Features

> - Keep your private keys in your client, **safe** and sound
> - Import and export **JSON wallets**
> - Import and export BIP 39 **mnemonic phrases** (12-word backup
>   phrases) and HD wallets (English, Italian, Japanese, Korean,
>   Simplified Chinese, Traditional Chinese; more coming soon)
> - Connect to Manifold Finance nodes over
>   [JSON-RPC](https://github.com/ethereum/wiki/wiki/JSON-RPC).
> - **Aliases names** are first-class citizens; it can be used to log
>   in any Manifold Finance services
> - **Complete** functionality for all your Manifold Finance needs
> - Extensive **documentation**
> - Large collection of **test cases** which are maintained and added
>   to
> - Fully **TypeScript**-ready, with definition files and full
>   TypeScript source
> - **MIT License** (including ALL dependencies); completely open
>   source, tweak as you please

### Getting Started

The manifold-sdk library is a compact and complete JavaScript library
for Manifold Finance protocol.

### Setup

Learn how to set up environment & create project.

#### Installing in Node.js

Install the manifold-sdk library from your project directory:

    $ npm install --save manifold-sdk

#### Importing

    var manifold = require('manifold-sdk');

    const manifold = require('manifold-sdk');

    import { manifold } from 'manifold-sdk';

##### Including in React Native

    import { manifold } from 'manifold-sdk';

#### Including in React

    import { manifold } from 'manifold-sdk';

##### Including in Vue.js

    import { manifold } from 'manifold-sdk';

##### Including in Web Applications

For security purposes, it is usually best to place a **copy** of [this
script](https://cdn.ethers.io/scripts/ethers-v4.min.js) on the
application's server; but using the Manifold Finance content distribution
network (CDN) should suffice for a quick prototype.

    <!-- This exposes the library as a global variable: manifold -->
    <script src="https://cdn.manifoldfinance.com/scripts/manifold-sdk-v1.min.js"
            charset="utf-8"
            type="text/javascript">
    </script>

## Network Provider

A network provider is an abstracts connection to the protocol, for
issuing queries and sending signed state-changing transactions.

The _JsonRpcProvider_ allows you to connect to protocol nodes that you
control or have access to, including mainnet, testnets, or localnets.

### Connecting to Blockchain

There are several methods to connect to the protocol network provider.
If you are not running your own local protocol node, it is recommended
that you use the `getDefaultProvider()` method.

<sup>manifold</sup> . getDefaultProvider( \[ network = "localnet" \] )   <span class="title-ref">=&gt; Provider</span>  
This creates a FallbackProvider backed by multiple backends.

This is the **recommended** method of connecting to the protocol
network if you are not running your own protocol node.

<!-- -->

    let networkProvider = manifold.getDefaultProvider("localnet");

#### JsonRpcProvider <sup>( inherits from Provider )</sup>

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
a protocol node.

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

### Properties

Not all properties are mutable unless otherwise specified, and will
reflect their default values if left unspecified.

#### Provider Variables

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

- _chainId_ the chain ID (network ID) of the connected network
- _name_ the name of the network (e.g., "testnet")

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

#### Account

_A 'dummy' wallet is used below, there is not real user behind it._

<sup>prototype</sup> . getBalance ( `AddressOrName <addressOrName>` )   <span class="title-ref">=&gt; Promise&lt;BigNumber&gt;</span>  
Returns a `Promise <promise>` with the balance (as a
`BigNumber <bignumber>`) of `AddressOrName <addressOrName>`.

<!-- -->

    let address = "manifold1x7tp9tt7mu0jm6qdmljgntvzzp53lrtndr7h8x";

    provider.getBalance(address).then((balance) => {

        // balance is a BigNumber (in cin); format is as a string (in manifold)
        let manifoldString = manifold.utils.formatMan(balance);

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

#### Blockchain Status

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

- **kyc** the route for kyc module

  - **kyc-whitelist** the whitelist transaction type
  - **kyc-revokeWhitelist** the revoke whitelist transaction
    type

- **bank** the route for bank module

  - **bank-send** the transfer MXW transaction type

- **token** the route for token module

  - **token-mintFungibleToken** the mint transaction type
  - **token-burnFungibleToken** the burn transaction type
  - **token-freeze** the freeze transaction type
  - **token-unfreeze** the unfreeze transaction type
  - **token-createFungibleToken** the create transaction type
  - **token-setFungibleTokenStatus** the set status transaction
    type

- **nameservice** the route for name service module
  - **nameservice-createAlias** the create transaction type
  - **nameservice-setAliasStatus** the set status transaction
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

    let value = utils.parseMan("10").toString();
    provider.getTransactionFee("bank", "bank-send").then((fee) => {
        console.log("Fee:", fee);
    });

#### Waiting for Transactions

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

#### Objects and Types

There are several common objects and types that are commonly used as
input parameters or return types for various provider calls.

##### Block Tag

A block tag is used to uniquely identify a block's position in the
protocol:

a Number or `hex string <hexstring>`:  
Each block has a block number (e.g., `1202` or `"0x4b2"`).

"latest":  
The most recently validated block.

"pending":  
The block that is currently being validated.

#### Provider-Specific Extra API Calls

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

## Utilities

The utility functions provide a large assortment of common utility
functions required to write dapps, process user input, and format data.

### Addresses

Wallet address is uses Bech32 format
([BIP-173](https://github.com/bitcoin/bips/blob/master/bip-0173.mediawiki)).
There are several formats available to represent wallet addresses and
they can be determined in various ways.

<div id="utils-get-address">

<sup>utils</sup> . getAddress ( address )   <span class="title-ref">=&gt; Address</span>  
Normalize any supported address-format to include checksum.

</div>

<div id="utils-compute-hex-address">

<sup>utils</sup> . computeHexAddress ( address )   <span class="title-ref">=&gt; Address</span>  
Convert the supported address-format to checksum hex-format.

</div>

<div id="utils-get-hash">

<sup>utils</sup> . getHash ( hash )   <span class="title-ref">=&gt; string</span>  
Convert the hash to checksum hex-format.

</div>

    let address = "manifold1x7tp9tt7mu0jm6qdmljgntvzzp53lrtndr7h8x";

    console.log(manifold.utils.getAddress(address));
    // manifold1x7tp9tt7mu0jm6qdmljgntvzzp53lrtndr7h8x
    console.log(manifold.utils.computeHexAddress(address));
    // 0x379612aD7EDf1f2de80DDFE489Ad8210691F8d73

    let hash = "0x47bef4762a8b5646f03b346e64cebde005370a2d4c0610c833fa17828ad1878e";
    console.log(manifold.utils.getHash(hash));
    // 0x47bef4762a8B5646F03B346E64cEBdE005370a2D4C0610C833Fa17828Ad1878e

### Array `ish`

An arrayish object is used to describe binary data and has met the
following conditions met:

> - has a _length_ property
> - has a value for each index from 0 up to (but excluding) _length_
> - has a valid byte for each value; a byte is an integer in the range
>   of 0 to 255
> - is **not** a string

**Examples:** `Buffer`, `[ 1, 2, 3 ]`, `Uint8Array`

<sup>utils</sup> . isArrayish ( object )   <span class="title-ref">=&gt; boolean</span>  
Returns true if _object_ can be treated as an arrayish object.

<sup>utils</sup> . arrayify ( hexStringOrBigNumberOrArrayish )   <span class="title-ref">=&gt; Uint8Array</span>  
Returns a Uint8Array of a hex string, BigNumber or of an
[Arrayish](#arrayish) object.

<sup>utils</sup> . concat ( arrayOfHexStringsAndArrayish )   <span class="title-ref">=&gt; Uint8Array</span>  
Returns a Uint8Array of all _arrayOfHexStringsAndArrayish_ concatenated.

<sup>utils</sup> . padZeros ( typedUint8Array, length )   <span class="title-ref">=&gt; Uint8Array</span>  
Returns a Uint8Array of _typedUint8Array_ with zeros prepended to
_length_ bytes.

<sup>utils</sup> . stripZeros ( hexStringOrArrayish )   <span class="title-ref">=&gt; Uint8Array</span>  
Returns a Uint8Array with all leading zero **bytes** striped.

### Big Numbers

A BigNumber is an immutable object which allows accurate math operations
on values larger than `JavaScript can accurately handle <ieee754>` to be
safely handled. See also: `Constants <constants>`

<sup>prototype</sup> . add ( otherValue )   <span class="title-ref">=&gt; BigNumber</span>  
Returns a new BigNumber of this plus _otherValue_.

<sup>prototype</sup> . sub ( otherValue )   <span class="title-ref">=&gt; BigNumber</span>  
Returns a new BigNumber of this minus _otherValue_.

<sup>prototype</sup> . mul ( otherValue )   <span class="title-ref">=&gt; BigNumber</span>  
Returns a new BigNumber of this times _otherValue_.

<sup>prototype</sup> . div ( otherValue )   <span class="title-ref">=&gt; BigNumber</span>  
Returns a new BigNumber of this divided by _otherValue_.

<sup>prototype</sup> . mod ( otherValue )   <span class="title-ref">=&gt; BigNumber</span>  
Returns a new BigNumber of this modulo _otherValue_.

<sup>prototype</sup> . maskn ( bits )   <span class="title-ref">=&gt; BigNumber</span>  
Returns a new BigNumber with the number of _bits_ masked.

<sup>prototype</sup> . eq ( otherValue )   <span class="title-ref">=&gt; boolean</span>  
Returns true if this is equal to _otherValue_.

<sup>prototype</sup> . lt ( otherValue )   <span class="title-ref">=&gt; boolean</span>  
Returns true if this is less than _otherValue_.

<sup>prototype</sup> . lte ( otherValue )   <span class="title-ref">=&gt; boolean</span>  
Returns true if this is less than or equal to _otherValue_.

<sup>prototype</sup> . gt ( otherValue )   <span class="title-ref">=&gt; boolean</span>  
Returns true if this is greater than _otherValue_.

<sup>prototype</sup> . gte ( otherValue )   <span class="title-ref">=&gt; boolean</span>  
Returns true if this is greater than or equal to _otherValue_.

<sup>prototype</sup> . isZero ( )   <span class="title-ref">=&gt; boolean</span>  
Returns true if this is equal to zero.

<sup>prototype</sup> . toNumber ( )   <span class="title-ref">=&gt; number</span>  
Returns a JavaScript number of the value.

An error is thrown if the value is outside the safe range for JavaScript
IEEE 754 64-bit floating point numbers (over 53 bits of mantissa).

<sup>prototype</sup> . toString ()   <span class="title-ref">=&gt; string</span>  
Returns a decimal string representation.

<sup>prototype</sup> . toHexString ( )   <span class="title-ref">=&gt; hex</span>  
Returns a hex string representation of the value.

#### Creating Instances

<sup>utils</sup> . bigNumberify ( value )   <sup>=&gt; BigNumber</sup>  
Returns a BigNumber instance of _value_. The _value_ may be anything
that can be reliably converted into a BigNumber:

| Type | Examples | Notes |
| | - | - |
| decimal string | `"42"`, `"-42"` | |
| hexadecimal string | `"0x2a"`, `"-0x2a"` | case-insensitive |
| numbers | `42`, `-42` | must be witin the [safe range](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/isSafeInteger) |
| `Arrayish <arrayish>` | `[ 30, 252 ]` | big-endian encoding |
| BigNumber | any other BigNumber | returns the same instance |

<!-- -->

    let value = utils.bigNumberify("12345678901234567890");
    let rate = utils.bigNumberify(3000000);

    let finalValue = value.mul(rate);
    console.log("Final value: " + finalValue.toString());
    // Final value: 37037036703703703670000000

    console.log("Number: " + finalValue.toNumber());
    // throws an error, the value is too large for JavaScript to handle safely

### Bytes32 Strings

Often for short strings, it is far more efficient to store them as a
fixed, null-terminated bytes32, instead of a dynamic length-prefixed
bytes.

<sup>utils</sup> . formatBytes32String ( text )   <span class="title-ref">=&gt; hex</span>  
Returns a `hex string <hexstring>` representation of _text_, exactly 32
bytes wide. Strings **must** be 31 bytes or shorter, or an exception is
thrown.

**NOTE:** Keep in mind that UTF-8 characters outside the ASCII range can
be multiple bytes long.

<sup>utils</sup> . parseBytes32String ( hexStringOrArrayish )   <span class="title-ref">=&gt; string</span>  
Returns _hexStringOrArrayish_ as the original string, as generated by
`formatBytes32String`.

<!-- -->

    let text = "Hello Blockchain!"

    let bytes32 = utils.formatBytes32String(text)
    // "0x48656c6c6f20426c6f636b636861696e21000000000000000000000000000000"

    let originalText = utils.parseBytes32String(bytes32)
    // "Hello Blockchain!"

## Constants

<sup>manifold . constants</sup> . AddressZero  
The address `manifold1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqgcpfl3`.

<sup>manifold . constants</sup> . HashZero  
The bytes32
`0x0000000000000000000000000000000000000000000000000000000000000000`.

<sup>manifold . constants</sup> . MaxUint256  
The bytes32
`0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff`.

<sup>manifold . constants</sup> . NegativeOne  
The `BigNumber <bignumber>` `bigNumberify(-1)`.

<sup>manifold . constants</sup> . Zero  
The `BigNumber <bignumber>` `bigNumberify(0)`.

<sup>manifold . constants</sup> . One  
The `BigNumber <bignumber>` `bigNumberify(1)`.

<sup>manifold . constants</sup> . Two  
The `BigNumber <bignumber>` `bigNumberify(2)`.

<sup>manifold . constants</sup> . CinPerMan  
The `BigNumber <bignumber>` `bigNumberify("1000000000000000000")`.

### Cryptographic Functions

#### Elliptic Curve

<sup>utils</sup> . computeAddress ( publicOrPrivateKey )   <span class="title-ref">=&gt; Address</span>  
Computes the address given a public key or private key.

<sup>utils</sup> . computeHexAddress ( address )   <span class="title-ref">=&gt; Address</span>  
Convert the supported address-format to checksum hex-format.

<div id="utils-get-hash">

<sup>utils</sup> . computePublicKey ( publicOrPrivateKey \[ , compressed <sup>= false</sup> \] )   <span class="title-ref">=&gt; hex</span>  
Computes the public key for _publicOrPrivateKey_, optionally
_compressed_. If _publicOrPrivateKey_ is a public key, it may be either
compressed or uncompressed.

<sup>utils</sup> . recoverAddress ( digest , signature \[ , recoveryParam \] )   <span class="title-ref">=&gt; Address</span>  
Returns the address by using ecrecover with the _digest_ for the
_signature_.

<sup>utils</sup> . recoverPublicKey ( digest , signature \[ , recoveryParam \] )   <span class="title-ref">=&gt; hex</span>  
Returns the public key by using ecrecover with the _digest_ for the
_signature_.

<sup>utils</sup> . verifyMessage ( messageStringOrArrayish , signature \[ , recoveryParam \] )   <span class="title-ref">=&gt; Addresss</span>  
Returns the address of the account that signed _messageStringOrArrayish_
to generate _signature_.

<sup>utils</sup> . verify ( messageStringOrArrayish , signature, address )   <span class="title-ref">=&gt; Boolean</span>  
Returns true if the signature is signed by the address.

</div>

    let privateKey = "0xca250aeca008d36b4b4ff83709343c9e4c4ea461e5aa5fa51d57a0fe11eb045e";
    let wallet = new manifold.Wallet(privateKey);
    let message = "Hello Blockchain!";

    return wallet.signMessage(message, true).then((signature) => {
        let address = utils.verifyMessage(message, signature);
        console.log("Signed by:", address);
        // manifold1x7tp9tt7mu0jm6qdmljgntvzzp53lrtndr7h8x
    });

#### Hash Functions

<sup>utils</sup> . sha256 ( hexStringOrArrayish )   <span class="title-ref">=&gt; hex</span>  
Computes the SHA2-256 cryptographic hash of a value, returned as a hex
string.

<!-- -->

    console.log(utils.sha256([ 0x12, 0x02 ]));
    // "0xa8b1b4fe0930de4baff9b55286f7ba78edbcb3f2b18f6ad7e9336c541bf60515"

    console.log(utils.sha256("0x1202"));
    // "0xa8b1b4fe0930de4baff9b55286f7ba78edbcb3f2b18f6ad7e9336c541bf60515"

#### Hash Function Helpers

<sup>utils</sup> . hashMessage ( stringOrArrayish )   <span class="title-ref">=&gt; hex</span>  
Computes the SHA2-256 value by converting the message to bytes (as
necessary).

<sup>utils</sup> . id ( utf8String )   <span class="title-ref">=&gt; hex</span>  
Computes the SHA2-256 cryptographic hash of a UTF-8 string, returned as
a hex string.

<!-- -->

    // Convert the string to binary data
    let message = "Hello Blockchain!";
    let messageBytes = utils.toUtf8Bytes(message);
    console.log(utils.sha256(messageBytes));
    // "0xdc2a5349136fe31362ddca95d7f8d3adb35c8eb3261f39ff519b1e33988a3b1f"

    // Which is equivalent to using the id function
    console.log(utils.id("Hello Blockchain!"));
    // "0xdc2a5349136fe31362ddca95d7f8d3adb35c8eb3261f39ff519b1e33988a3b1f"

#### Key Derivation

<div id="pbkdf2">

<sup>utils</sup> . pbkdf2 ( password , salt , iterations , keylen , hashAlgorithm )  
Returns the PBKDF2-derived key from _password_ and _salt_ with
_iterations_ of _length_ using the _hashAlgorithm_. The supported hash
algorithms are `sha256` and `sha512`.

</div>

#### Random

<sup>utils</sup> . randomBytes ( length )   <span class="title-ref">=&gt; Uint8Array</span>  
Returns a Uint8Array of cryptographically secure random bytes.

<!-- -->

    let randomBytes3 = utils.randomBytes(3)
    // Uint8Array [ 127, 203, 43 ]

    let randomBytes32 = utils.randomBytes(32)
    // Uint8Array [ 150, 131, 148, 78, 45, 225, 72, 89, 145, 104, 97, 29,
    //              252, 55, 70, 88, 203, 255, 151, 106, 241, 106, 1, 87,
    //              3, 109, 34, 166, 122, 132, 176, 209 ]

    let randomNumber = utils.bigNumberify(utils.randomBytes(32));
    // BigNumber { _hex: 0x5de9cfc233211c316be4a1eb0fd6d9f8244386a704681310a8f59a4b7cebe2a5 }

### MXW Strings and Cin

<div id="parseMan">

<sup>utils</sup> . parseMan ( manifoldString )   <span class="title-ref">=&gt; BigNumber</span>  
Parses the _manifoldString_ representation of MXW into a BigNumber
instance of the amount of cin.

</div>

<div id="formatMan">

<sup>utils</sup> . formatMan ( cin )   <span class="title-ref">=&gt; string</span>  
Formats an amount of _cin_ into a decimal string representing the amount
of MXW. The output will always include at least one whole number and at
least one decimal place, otherwise leading and trailing 0's will be
trimmed.

</div>

<div id="parseUnits">

<sup>utils</sup> . parseUnits ( valueString , decimalsOrUnitName )   <span class="title-ref">=&gt; BigNumber</span>  
Parses the _valueString_ representation of units into a BigNumber. The
_decimalsOrUnitsName_ may be a number of decimals between 3 and 18
(multiplication of 3).

</div>

<div id="formatUnits">

<sup>utils</sup> . formatUnits ( value , decimalsOrUnitName )   <span class="title-ref">=&gt; string</span>  
Formats an amount of cin into a decimal string representing the amount
of units. The output will always include at least one whole number and
at least one decimal place, otherwise leading and trailing 0's will be
trimmed. The _decimalsOrUnitsName_ may be a number of decimals between 3
and 18 (multiplication of 3).

<sup>utils</sup> . commify ( numberOrString )   <span class="title-ref">=&gt; string</span>  
Returns _numberOrString_ with commas placed at every third position
within the whole component. If _numberOrString_ contains a decimal
point, the output will also contain at least one digit for both the
whole and decimal components. If there no decimal, then the output will
also not contain a decimal.

</div>

    let value = utils.parseMan('1000.0');
    console.log(value.toString());
    // "1000000000000000000000"

    console.log(utils.formatMan(0));
    // "0.0"

    let cin = utils.bigNumberify("1000000000000000000000");

    console.log(utils.formatMan(cin));
    // "1000.0"

    console.log(utils.commify(cin.toString()));
    // "1,000,000,000,000,000,000,000"

### Hex Strings

A hex string is **always** prefixed with "0x" and consists of the
characters 0-9 and a-f. It is always returned lowercase with even
length, but any hex string passed into a function may be any case and
may be odd length.

<sup>utils</sup> . hexlify ( numberOrBigNumberOrHexStringOrArrayish )   <span class="title-ref">=&gt; hex</span>  
Converts any number, `BigNumber <bignumber>`, hex string, or
[Arrayish](#arrayish) to a hex string. (Otherwise, throws an error)

<sup>utils</sup> . isHexString ( value )   <span class="title-ref">=&gt; boolean</span>  
Returns true if _value_ is a valid hexstring.

<sup>utils</sup> . hexDataLength ( hexString )   <span class="title-ref">=&gt; number</span>  
Returns the length (in bytes) of _hexString_ if it is a valid data hex
string data (even length).

<sup>utils</sup> . hexStripZeros ( hexString )   <span class="title-ref">=&gt; hex</span>  
Returns _hexString_ with all leading zeros removed, but retaining at
least one nibble, even if zero (e.g., `0x0`). This may return an odd
length string.

<sup>utils</sup> . hexZeroPad ( hexString , length )   <span class="title-ref">=&gt; hex</span>  
Returns _hexString_ padded (on the left) with zeros to length of
**bytes** (each byte is two nibbles).

### Signatures

There are two common formats for signatures in Manifold Finance. The
**flat-format**, which is a hex string with 65 bytes (with
recoveryParam); or 64 bytes (without recoveryParam); or an
**expanded-format**, which is an object with the following properties:

> - **r** and **s** the (r, s) public point of a signature
> - **recoveryParam** the recovery parameter of a signautre
>   (either `0` or `1`)
> - **v** the recovery parameter nomalized (either `27` or `28`)

<sup>utils</sup> . splitSignature ( hexStringOrArrayishOrSignature )   <span class="title-ref">=&gt; Signature</span>  
Returns an expanded-format signature object for
_hexStringOrArrayishOrSignature_. Passing in an signature that is
already in the expanded-format will ensure both _recoveryParam_ and _v_
are populated.

<sup>utils</sup> . joinSignature ( signature \[ , includeRecoveryParam \] )   <span class="title-ref">=&gt; hex</span>  
Returns the flat-format signature hexstring of _signature_. The final
_v_ byte will always be normalized to `0x1b` of `0x1c`. Optionally to
include recovery parameter.

<!-- -->

    // Flat-format: this is the format provided by JSON-RPC responses
    let flat = "0xd26c2cd5c6adb03046ac99e5d9badb798ca9b09f995191b5b906d6c26f8983e4" +
                 "1b7116df50a27a8c9e52fae512728ef75623da13320ca9b2e62ece0dcdd409e9" +
                 "1b";
    let expanded = utils.splitSignature(flat);

    console.log(expanded);
    // { r: "0xd26c2cd5c6adb03046ac99e5d9badb798ca9b09f995191b5b906d6c26f8983e4",
    //   s: "0x1b7116df50a27a8c9e52fae512728ef75623da13320ca9b2e62ece0dcdd409e9",
    //   recoveryParam: 0,
    //   v: 27
    // }

    // Expanded-format: this is the format and other tools often require
    let expanded = {
        r: "0xd26c2cd5c6adb03046ac99e5d9badb798ca9b09f995191b5b906d6c26f8983e4",
        s: "0x1b7116df50a27a8c9e52fae512728ef75623da13320ca9b2e62ece0dcdd409e9",
        recoveryParam: 0,
        v: 27
    }
    let flat = utils.joinSignature(expanded, true);

    console.log(flat)
    // "0xd26c2cd5c6adb03046ac99e5d9badb798ca9b09f995191b5b906d6c26f8983e4"
    // "1b7116df50a27a8c9e52fae512728ef75623da13320ca9b2e62ece0dcdd409e91b"

### UTF-8 Strings

<div id="utf8-to-bytes">

<sup>utils</sup> . toUtf8Bytes ( string )   <span class="title-ref">=&gt; Uint8Array</span>  
Converts a UTF-8 string to a Uint8Array.

</div>

<div id="utf8-to-string">

<sup>utils</sup> . toUtf8String ( hexStringOrArrayish \[ , ignoreErrors <sup>= false</sup> \] )   <span class="title-ref">=&gt; string</span>  
Converts a hex-encoded string or array to its UTF-8 representation.

</div>

    let text = "Hello Blockchain!";
    let bytes = utils.toUtf8Bytes(text);

    console.log(bytes);
    // Uint8Array [ 72, 101, 108, 108, 111, 32, 66, 108, 111, 99, 107, 99, 104, 97, 105, 110, 33 ]

    let array = [ 72, 101, 108, 108, 111, 32, 66, 108, 111, 99, 107, 99, 104, 97, 105, 110, 33 ];
    let stringFromArray = utils.toUtf8String(array);

    console.log(stringFromArray);
    // "Hello Blockchain!"

    let hexString = "0x48656c6c6f20426c6f636b636861696e21";
    let stringFromHexString = utils.toUtf8String(hexString);

    console.log(stringFromHexString);
    // "Hello Blockchain!"

### Using the SDK

<div class="toctree" maxdepth="4">

introduction api-1wallet api-2providers api-4kyc api-5tokens api-6nft
api-7name-service api-8utils api-9misc

</div>

## Acknowledgement

Much 😍 to
[ethers.js](https://github.com/ethers-io/ethers.js/)
