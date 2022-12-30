#!/usr/bin/env bash
# execute dos2unix [filename] if [No such file or directory] message appear.

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d && echo