#!/usr/bin/env bash

openssl genpkey -algorithm RSA -out app-private.pem -pkeyopt rsa_keygen_bits:2048
openssl rsa -in app-private.pem -pubout -out app-public.pem
