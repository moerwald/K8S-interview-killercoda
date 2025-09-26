#!/usr/bin/env bash
set -e
kubectl -n t3 get deploy/web >/dev/null 2>&1 || exit 1
kubectl -n t3 get secret/app-secret >/dev/null 2>&1 || exit 1
kubectl -n t3 get configmap/app-config >/dev/null 2>&1 || exit 1
echo "done"