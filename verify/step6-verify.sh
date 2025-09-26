#!/usr/bin/env bash
set -e
kubectl -n t6 get networkpolicy/default-deny >/dev/null 2>&1 || exit 1
kubectl -n t6 get networkpolicy/allow-web-from-ingress-and-same-namespace >/dev/null 2>&1 || exit 1
echo "done"