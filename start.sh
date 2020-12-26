#!/bin/bash
nvm use 12
lerna || exit 1
lerna bootstrap --no-ci
