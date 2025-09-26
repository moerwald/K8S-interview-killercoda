#!/usr/bin/env bash
set -e
kubectl -n t5 get hpa/burner-hpa >/dev/null 2>&1 || exit 1
echo "done"