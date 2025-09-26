#!/usr/bin/env bash
set -e
kubectl -n t2 get ingress/web >/dev/null 2>&1 || exit 1
echo "done"