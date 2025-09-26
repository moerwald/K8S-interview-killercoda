## Task 05 — HPA (namespace `t5`)

Create a CPU-based HPA (50% target, min=2, max=6) for a small load generator.

**Commands**

```bash
kubectl create ns t5
kubectl -n t5 apply -f /root/killercoda/assets/hpa.yaml
kubectl -n t5 get hpa
watch -n 5 kubectl -n t5 get hpa,pods
```

**What to check**

- HPA shows utilization (not `<unknown>`); scales out under load and later back in.
- Candidate explains CPU% is relative to **requests**.