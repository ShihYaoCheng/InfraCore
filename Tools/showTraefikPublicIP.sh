#!/usr/bin/env bash
# execute dos2unix [filename] if [No such file or directory] message appear.

kubectl get service traefik -n traefik --output jsonpath='{.status.loadBalancer.ingress[0].ip}'