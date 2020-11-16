.. _start:

***************
Getting Started
***************

| The manifold-sdk library is a compact and complete JavaScript library for Manifold Finance protocol.

-----

Setup
#####

Learn how to set up environment & create project.

Installing in Node.js
---------------------

Install the manifold-sdk library from your project directory::

   $ npm install --save manifold-sdk

Importing
---------

.. code-block:: javascript
    :caption: *JavaScript (ES3)*

    var manifold = require('manifold-sdk');

.. code-block:: javascript
    :caption: *JavaScript (ES5 or ES6)*

    const manifold = require('manifold-sdk');

.. code-block:: javascript
    :caption: *JavaScript (ES6) / TypeScript*


    import { manifold } from 'manifold-sdk';

Including in React Native
"""""""""""""""""""""""""

.. code-block:: javascript
    :caption: *JavaScript (ES6) / TypeScript*

    import { manifold } from 'manifold-sdk';

Including in React
------------------

.. code-block:: javascript
    :caption: *JavaScript (ES6) / TypeScript*

    import { manifold } from 'manifold-sdk';

Including in Vue.js
"""""""""""""""""""

.. code-block:: javascript
    :caption: *JavaScript (ES6) / TypeScript*

    import { manifold } from 'manifold-sdk';

Including in Web Applications
"""""""""""""""""""""""""""""

For security purposes, it is usually best to place a **copy** of `this script`_ on
the application's server; but using the Manifold Finance content distribution network (CDN) 
should suffice for a quick prototype.

.. code-block:: html
    :caption: *HTML*

    <!-- This exposes the library as a global variable: manifold -->
    <script src="https://cdn.manifoldfinance.com/scripts/manifold-sdk-v1.min.js"
            charset="utf-8"
            type="text/javascript">
    </script>

-----


.. _npm is installed: https://nodejs.org/en/
.. _this script: https://cdn.ethers.io/scripts/ethers-v4.min.js

