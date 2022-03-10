#!/usr/bin/env bash
# execute dos2unix [filename] if [No such file or directory] message appear.

# required files:
# 1. certificate.crt
# 2. private.key
# 3. sealedSecretPublic.crt

kubectl create secret tls zerossl-certificate -n nginx \
--dry-run=client \
--cert=certificate.crt \
--key=private.key -o yaml > SecretZerosslCertificate.yaml

kubeseal --cert sealedSecretPublic.crt < SecretZerosslCertificate.yaml \
--controller-name=sealed-secret-sealed-secrets \
--controller-namespace=kube-system \
--format yaml > SealedSecretZerosslCertificate.yaml
