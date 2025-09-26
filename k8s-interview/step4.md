## Task 04 — Debug a CrashLoopBackOff (namespace `t4`)

A Deployment references a missing ConfigMap. Diagnose and fix.

**Commands**

```bash
kubectl create ns t4
kubectl -n t4 apply -f /root/killercoda/assets/broken.yaml
kubectl -n t4 get pods
kubectl -n t4 describe pod -l app=buggy
kubectl -n t4 logs deploy/buggy --previous || true

# One fix: create the referenced ConfigMap and restart
kubectl -n t4 create configmap missing-config --from-literal=value=ok
kubectl -n t4 rollout restart deploy/buggy
kubectl -n t4 get pods
```

**What to check**

- Uses events and `--previous` logs to identify cause.
- Pod stabilizes to `Running`.