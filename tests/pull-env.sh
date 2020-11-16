#!/bin/sh
if ! [ -d "./env" ]
then
    mkdir env
fi;

if ! [ -d "./env/manifold-sdk-secret" ]
then
    cd env
    # Dont follow me...
    git clone git@gitlab.com:manifold/manifold-sdk-secret.git
    cd ..
else
    cd env/manifold-sdk-secret
    # Dont follow me...
    git pull
    cd ../..
fi;
cp -f env/manifold-sdk-secret/env.ts env.ts
