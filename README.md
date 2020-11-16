---
title: manifold finance sdk
description: a well typed sdk for web3
version: 0.1.1
---

# `manifold-sdk`

> a human web3 interface

---

**SDK Overview:**

- Keep your private keys in your client, **safe** and sound
- Import and export **JSON wallets**
- Import and export BIP 39 **mnemonic phrases** (12-word backup phrases) and HD wallets (English, Italian, Japanese, Korean, Simplified Chinese, Traditional Chinese)
- Connect to Ethereum nodes over `JSON-RPC` (both public and private).
- **Aliases names** are first-class citizens; it can be used to log in any Manifold Finance services
- **Complete** functionality for all your Manifold Finance needs
- Large collection of **test cases** which are maintained and added to
- Fully **TypeScript**-ready, with definition files and full TypeScript source

---

## usage

`make build` <br>

`npm install --save manifold-sdk`

## importing

**JavaScript (ES3)**

    var manifold = require('manifold-sdk');

**JavaScript (ES5 or ES6)**

    const manifold = require('manifold-sdk');

**JavaScript (ES6) / TypeScript**

    import { manifold } from 'manifold-sdk';

---

### example

```javascript
const Web3 = require("web3");
const BN = Web3.utils.BN;
const ManifoldProvider = require("@manifold/provider");

class GasEVO {
  constructor(options) {
    this.GasEVO = null;

    this.pollingInterval = null;
    this.account = null;
    this.unlocked = false;
    this.balanceWei = 0;
    this.balance = 0;
    this.address = "REPLACE_WITH_CONTRACT_ADDRESS";
    this.genesisBlock = 0;
    this.loading = false;
    this.options = {
      readonlyRpcURL: "https://mainnet.infura.io",
      autoInit: true,
      getPastEvents: false,
      watchFutureEvents: false,
      connectionRetries: 3,
    };
    Object.assign(this.options, options);
    if (this.options.autoInit) this.initWeb3();
  }

  /*
   * Connect
   */

  initWeb3() {
    return new Promise((resolve, reject) => {
      let web3Provider = false;

      // check for metamask
      if (global.web3) {
        web3Provider = global.web3.currentProvider;
        // attempt to try again if no web3Provider
      } else if (this.options.connectionRetries > 0) {
        this.options.connectionRetries -= 1;
        setTimeout(() => {
          this.initWeb3()
            .then(resolve)
            .catch((error) => {
              reject(new Error(error));
            });
        }, 1000);
        // revert to a read only version using infura endpoint
      } else {
        this.readOnly = true;
        web3Provider = ZeroClientProvider({
          getAccounts: function () {},
          rpcUrl: this.options.readonlyRpcURL,
        });
      }

      if (web3Provider) {
        global.web3 = new Web3(web3Provider);
        this.startChecking();

        if (this.options.getPastEvents) this.getPastEvents();
        if (this.options.watchFutureEvents) this.watchFutureEvents();
      }
    });
  }

  /*
   * Check every second for switching network or switching wallet
   */

  startChecking() {
    if (this.pollingInterval) clearInterval(this.pollingInterval);
    this.getGenesisBlock()
      .then(() => {
        this.pollingInterval = setInterval(this.check.bind(this), 1000);
      })
      .catch((err) => {
        throw new Error(err);
      });
  }

  check() {
    this.checkNetwork()
      .then(this.checkAccount.bind(this))
      .catch((error) => {
        console.error(error);
        throw new Error(error);
      });
  }

  checkNetwork() {
    return global.web3.eth.net.getId((err, netId) => {
      if (err) console.error(err);
      if (!err && this.network !== netId) {
        this.network = netId;
        return this.deployContract();
      }
    });
  }

  checkAccount() {
    return global.web3.eth.getAccounts((error, accounts) => {
      if (error) throw new Error(error);
      if (accounts.length && this.account !== accounts[0]) {
        this.unlocked = true;
        this.account = accounts[0];
      } else if (!accounts.length) {
        this.unlocked = false;
        this.account = null;
      }
    });
  }

  /*
   *
   * Constant Functions
   *
   */

  DAY_IN_SECONDS() {
    return this.GasEVO.methods
      .DAY_IN_SECONDS()
      .call()
      .then((resp) => {
        return resp;
      })
      .catch((err) => {
        console.error(err);
      });
  }
  NUM_OF_RATES() {
    return this.GasEVO.methods
      .NUM_OF_RATES()
      .call()
      .then((resp) => {
        return resp;
      })
      .catch((err) => {
        console.error(err);
      });
  }
  allowance(owner, spender) {
    return this.GasEVO.methods
      .allowance(owner, spender)
      .call()
      .then((resp) => {
        return resp;
      })
      .catch((err) => {
        console.error(err);
      });
  }
  balanceOf(account) {
    return this.GasEVO.methods
      .balanceOf(account)
      .call()
      .then((resp) => {
        return resp;
      })
      .catch((err) => {
        console.error(err);
      });
  }
  decimals() {
    return this.GasEVO.methods
      .decimals()
      .call()
      .then((resp) => {
        return resp;
      })
      .catch((err) => {
        console.error(err);
      });
  }
  name() {
    return this.GasEVO.methods
      .name()
      .call()
      .then((resp) => {
        return resp;
      })
      .catch((err) => {
        console.error(err);
      });
  }
  symbol() {
    return this.GasEVO.methods
      .symbol()
      .call()
      .then((resp) => {
        return resp;
      })
      .catch((err) => {
        console.error(err);
      });
  }
  totalSupply() {
    return this.GasEVO.methods
      .totalSupply()
      .call()
      .then((resp) => {
        return resp;
      })
      .catch((err) => {
        console.error(err);
      });
  }
  getEthDeposit() {
    return this.GasEVO.methods
      .getEthDeposit()
      .call()
      .then((resp) => {
        return resp;
      })
      .catch((err) => {
        console.error(err);
      });
  }
  getTotalRate(day) {
    return this.GasEVO.methods
      .getTotalRate(new BN(day, 10))
      .call()
      .then((resp) => {
        return resp;
      })
      .catch((err) => {
        console.error(err);
      });
  }
  getHolderRate(holder, day) {
    return this.GasEVO.methods
      .getHolderRate(holder, new BN(day, 10))
      .call()
      .then((resp) => {
        return resp;
      })
      .catch((err) => {
        console.error(err);
      });
  }
  convEvo2Eth(amountEvo) {
    return this.GasEVO.methods
      .convEvo2Eth(new BN(amountEvo, 10))
      .call()
      .then((resp) => {
        return resp;
      })
      .catch((err) => {
        console.error(err);
      });
  }
  convEth2Evo(amountEth) {
    return this.GasEVO.methods
      .convEth2Evo(new BN(amountEth, 10))
      .call()
      .then((resp) => {
        return resp;
      })
      .catch((err) => {
        console.error(err);
      });
  }
  getRates(holder, _timestamp) {
    return this.GasEVO.methods
      .getRates(holder, new BN(_timestamp, 10))
      .call()
      .then((resp) => {
        return resp;
      })
      .catch((err) => {
        console.error(err);
      });
  }
  getEvoInterestPct(holder, amountEvo) {
    return this.GasEVO.methods
      .getEvoInterestPct(holder, new BN(amountEvo, 10))
      .call()
      .then((resp) => {
        return resp;
      })
      .catch((err) => {
        console.error(err);
      });
  }
  getEvoInterestPct(holder, amountEvo, _timestamp) {
    return this.GasEVO.methods
      .getEvoInterestPct(holder, new BN(amountEvo, 10), new BN(_timestamp, 10))
      .call()
      .then((resp) => {
        return resp;
      })
      .catch((err) => {
        console.error(err);
      });
  }
  getEvoInterest(holder, amountEvo, _timestamp) {
    return this.GasEVO.methods
      .getEvoInterest(holder, new BN(amountEvo, 10), new BN(_timestamp, 10))
      .call()
      .then((resp) => {
        return resp;
      })
      .catch((err) => {
        console.error(err);
      });
  }
  getEvoInterest(holder, amountEvo) {
    return this.GasEVO.methods
      .getEvoInterest(holder, new BN(amountEvo, 10))
      .call()
      .then((resp) => {
        return resp;
      })
      .catch((err) => {
        console.error(err);
      });
  }

  /*
   *
   * Transaction Functions
   *
   */

  approve(spender, amount) {
    if (!this.account) return Promise.reject(new Error("Unlock Account"));
    return this.GasEVO.methods
      .approve(spender, new BN(amount, 10))
      .send({ from: this.account })
      .on("transactionHash", (hash) => {
        console.log(hash);
        this.loading = true;
      })
      .then((resp) => {
        this.loading = false;
        return resp;
      })
      .catch((err) => {
        this.loading = false;
        console.error(err);
      });
  }
  decreaseAllowance(spender, subtractedValue) {
    if (!this.account) return Promise.reject(new Error("Unlock Account"));
    return this.GasEVO.methods
      .decreaseAllowance(spender, new BN(subtractedValue, 10))
      .send({ from: this.account })
      .on("transactionHash", (hash) => {
        console.log(hash);
        this.loading = true;
      })
      .then((resp) => {
        this.loading = false;
        return resp;
      })
      .catch((err) => {
        this.loading = false;
        console.error(err);
      });
  }
  increaseAllowance(spender, addedValue) {
    if (!this.account) return Promise.reject(new Error("Unlock Account"));
    return this.GasEVO.methods
      .increaseAllowance(spender, new BN(addedValue, 10))
      .send({ from: this.account })
      .on("transactionHash", (hash) => {
        console.log(hash);
        this.loading = true;
      })
      .then((resp) => {
        this.loading = false;
        return resp;
      })
      .catch((err) => {
        this.loading = false;
        console.error(err);
      });
  }
  withdrawEth(amountEvo) {
    if (!this.account) return Promise.reject(new Error("Unlock Account"));
    return this.GasEVO.methods
      .withdrawEth(new BN(amountEvo, 10))
      .send({ from: this.account })
      .on("transactionHash", (hash) => {
        console.log(hash);
        this.loading = true;
      })
      .then((resp) => {
        this.loading = false;
        return resp;
      })
      .catch((err) => {
        this.loading = false;
        console.error(err);
      });
  }
  transfer(_to, _value) {
    if (!this.account) return Promise.reject(new Error("Unlock Account"));
    return this.GasEVO.methods
      .transfer(_to, new BN(_value, 10))
      .send({ from: this.account })
      .on("transactionHash", (hash) => {
        console.log(hash);
        this.loading = true;
      })
      .then((resp) => {
        this.loading = false;
        return resp;
      })
      .catch((err) => {
        this.loading = false;
        console.error(err);
      });
  }
  transferFrom(_from, _to, _value) {
    if (!this.account) return Promise.reject(new Error("Unlock Account"));
    return this.GasEVO.methods
      .transferFrom(_from, _to, new BN(_value, 10))
      .send({ from: this.account })
      .on("transactionHash", (hash) => {
        console.log(hash);
        this.loading = true;
      })
      .then((resp) => {
        this.loading = false;
        return resp;
      })
      .catch((err) => {
        this.loading = false;
        console.error(err);
      });
  }

  /*
   *
   * end examples
   *
   */
}
```

## acknowledgements

portions from `ethers.js` with much modification

### license

SPDX-License-Identifier: MIT
