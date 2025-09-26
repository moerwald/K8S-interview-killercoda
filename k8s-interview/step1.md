## Task 01 — Deploy (namespace `t1`)

Deploy a 3-replica stateless app with probes and resource requests/limits. Verify a healthy rollout.

**Commands**

```bash
kubectl create ns t1
kubectl -n t1 apply -f /root/killercoda/assets/deploy.yaml
kubectl -n t1 get deploy,rs,pods -o wide
kubectl -n t1 rollout status deploy/web
```

**What to check**

- Probes pass; pods Ready with `RESTARTS 0`.
- Uses `rollout status` to confirm success.