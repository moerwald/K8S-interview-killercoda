#!/usr/bin/env bash
export KUBECONFIG=/root/.kube/config
echo "⌛ Provisioning cluster in the background... tail -f /root/bootstrap.log in a split pane if curious."
echo "When you see 'Cluster ready.' in /root/bootstrap.log, you can start."