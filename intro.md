# Kubernetes Interview: Hands‑on Assessment

This scenario provisions a **multi-node Kubernetes cluster** and walks you through 6 tasks. Use a fresh namespace per task (`t1`..`t6`). You can use docs at any time.

When the terminal is ready, the environment will automatically:
- Install **k3d** and create a cluster: 1 server + 2 agents
- Install **metrics-server**, **ingress-nginx**, and **local-path** default StorageClass
- Preload helper CLIs (`kubectl`, `k9s` if available)

> If cluster bootstrap is still running, you'll see a message at the top of the terminal. Wait until it says **Cluster ready**.

---

**Cluster info (after bootstrap):**

```bash
kubectl cluster-info
kubectl get nodes -o wide
```

Move to **Task 01** when ready.