#!/usr/bin/env bash
set -euo pipefail

LOG=/root/bootstrap.log
echo "[*] Using pre-provisioned kubeadm cluster." | tee -a "$LOG"

# Ensure kubectl works (it should already be present)
kubectl version --client

# Install metrics-server if you need HPA
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
