#!/usr/bin/env bash
set -e
kubectl -n t4 get deploy/buggy >/dev/null 2>&1 || exit 1
kubectl -n t4 get configmap/missing-config >/dev/null 2>&1 || exit 1
echo "done"