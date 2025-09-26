#!/usr/bin/env bash
set -euo pipefail

LOG=/root/bootstrap.log
echo "[*] Starting background bootstrap..." | tee -a "$LOG"

# Ensure deps
export DEBIAN_FRONTEND=noninteractive
apt-get update -y >>"$LOG" 2>&1 || true
apt-get install -y curl ca-certificates apt-transport-https jq conntrack socat iproute2 >>"$LOG" 2>&1 || true

# kubectl
if ! command -v kubectl >/dev/null 2>&1; then
  curl -fsSL https://storage.googleapis.com/kubernetes-release/release/stable.txt -o /tmp/k8sver
  KVER=$(cat /tmp/k8sver)
  curl -fsSL "https://storage.googleapis.com/kubernetes-release/release/${KVER}/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl
  chmod +x /usr/local/bin/kubectl
fi

# k3d
if ! command -v k3d >/dev/null 2>&1; then
  curl -fsSL https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash >>"$LOG" 2>&1
fi

# Create cluster if missing
if ! k3d cluster list | grep -q '^interview'; then
  k3d cluster create interview --agents 2 --servers 1 --wait --timeout 120s >>"$LOG" 2>&1
fi

export KUBECONFIG=/root/.kube/config
mkdir -p /root/.kube
k3d kubeconfig get interview > "$KUBECONFIG"

# Addons
echo "[*] Installing metrics-server..." | tee -a "$LOG"
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml >>"$LOG" 2>&1 || true

echo "[*] Installing ingress-nginx..." | tee -a "$LOG"
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml >>"$LOG" 2>&1 || true
kubectl -n ingress-nginx rollout status deploy/ingress-nginx-controller --timeout=180s >>"$LOG" 2>&1 || true

echo "[*] Installing local-path-provisioner and default StorageClass..." | tee -a "$LOG"
kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml >>"$LOG" 2>&1 || true
kubectl patch storageclass local-path -p '{"metadata":{"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}' >>"$LOG" 2>&1 || true

echo "[*] Cluster ready." | tee -a "$LOG"