#!/usr/bin/env bash
set -e
kubectl -n t1 get deploy/web >/dev/null 2>&1 || exit 1
kubectl -n t1 rollout status deploy/web --timeout=30s >/dev/null 2>&1 || exit 1
echo "done"