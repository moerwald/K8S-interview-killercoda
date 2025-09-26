#!/usr/bin/env bash
set -euo pipefail
LOG=/root/bootstrap.log
READY=/root/READY
echo "[*] Starting background bootstrap..." | tee -a "$LOG"

export DEBIAN_FRONTEND=noninteractive
apt-get update -y >>"$LOG" 2>&1 || true
apt-get install -y curl ca-certificates apt-transport-https jq conntrack socat iproute2 iptables docker.io >>"$LOG" 2>&1 || true

# Start Docker even if systemd isn't available
if ! docker info >/dev/null 2>&1; then
  echo "[*] starting dockerd (no systemd)..." | tee -a "$LOG"
  nohup dockerd --host=unix:///var/run/docker.sock --storage-driver=overlay2 >/root/dockerd.log 2>&1 &
  for i in {1..90}; do
    docker info >/dev/null 2>&1 && { echo "[*] docker is up." | tee -a "$LOG"; break; }
    echo "[*] waiting for docker... ($i)" | tee -a "$LOG"
    sleep 2
  done
fi

# kubectl
if ! command -v kubectl >/dev/null 2>&1; then
  echo "[*] Installing kubectl..." | tee -a "$LOG"
  ver="$(curl -fsSL https://storage.googleapis.com/kubernetes-release/release/stable.txt)"
  curl -fsSL "https://storage.googleapis.com/kubernetes-release/release/${ver}/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl
  chmod +x /usr/local/bin/kubectl
fi

# k3d (binary, avoid raw.githubusercontent.com)
if ! command -v k3d >/dev/null 2>&1; then
  echo "[*] Installing k3d..." | tee -a "$LOG"
  if curl -fsSL "https://github.com/k3d-io/k3d/releases/latest/download/k3d-linux-amd64" -o /usr/local/bin/k3d; then
    chmod +x /usr/local/bin/k3d
  else
    echo "[!] latest k3d failed, trying pinned version..." | tee -a "$LOG"
    K3D_VER=${K3D_VER:-v5.6.0}
    curl -fsSL "https://github.com/k3d-io/k3d/releases/download/${K3D_VER}/k3d-linux-amd64" -o /usr/local/bin/k3d
    chmod +x /usr/local/bin/k3d
  fi
fi

# Cluster
if ! k3d cluster list | grep -q '^interview'; then
  echo "[*] Creating k3d cluster..." | tee -a "$LOG"
  k3d cluster create interview --agents 2 --servers 1 --wait --timeout 300s >>"$LOG" 2>&1
fi

# Kubeconfig
export KUBECONFIG=/root/.kube/config
mkdir -p /root/.kube
k3d kubeconfig get interview > "$KUBECONFIG"

# Addons
echo "[*] Installing metrics-server..." | tee -a "$LOG"
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml >>"$LOG" 2>&1 || true

echo "[*] Installing local-path-provisioner (default SC)..." | tee -a "$LOG"
kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml >>"$LOG" 2>&1 || true
kubectl patch storageclass local-path -p '{"metadata":{"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}' >>"$LOG" 2>&1 || true

echo "[*] Installing ingress-nginx..." | tee -a "$LOG"
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml >>"$LOG" 2>&1 || true
kubectl -n ingress-nginx rollout status deploy/ingress-nginx-controller --timeout=300s >>"$LOG" 2>&1 || true

echo "[*] Cluster ready." | tee -a "$LOG"
touch "$READY"
