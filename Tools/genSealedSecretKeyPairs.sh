#!/usr/bin/env bash
openssl req -x509 -nodes -newkey rsa:4096 -keyout sealedSecretPrivate.key -out sealedSecretPublic.crt -subj "/CN=sealed-secret/O=sealed-secret"
kubectl -n kube-system create secret tls sealedsecret-keypair --dry-run=client --cert=sealedSecretPublic.crt --key=sealedSecretPrivate.key -o yaml > sealedSecretKeyPair.yaml

#printf "\n====== Sealed Secret Public ======\n"
#base64 -w 0 sealedSecretPublic.crt

#printf "\n\n====== Sealed Secret Private ======\n"
#base64 -w 0 sealedSecretPrivate.key
