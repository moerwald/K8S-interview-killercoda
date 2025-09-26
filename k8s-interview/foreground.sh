
#!/usr/bin/env bash
export KUBECONFIG=/root/.kube/config
echo "⌛ Provisioning cluster in the background..."
until [ -f /root/READY ]; do
  sleep 2
  [ -f /root/bootstrap.log ] && tail -n 2 /root/bootstrap.log || true
done
echo "✅ Cluster ready. Try: kubectl get nodes"
