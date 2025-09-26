## Task 06 — NetworkPolicy (namespace `t6`)

Enforce default-deny; allow only ingress-nginx namespace and same-namespace pods to reach Service `web`.

**Commands**

```bash
kubectl create ns t6
kubectl -n t6 apply -f /root/killercoda/assets/netpol.yaml

# Positive test (same ns)
kubectl -n t6 run dbg --image=busybox:1.36 --restart=Never -it -- wget -qO- http://web

# Negative test (other ns)
kubectl create ns other
kubectl -n other run dbg --image=busybox:1.36 --restart=Never -- wget -qO- http://web.t6.svc.cluster.local || echo "blocked as expected"
```

**What to check**

- Default-deny in place; cross-namespace access blocked; same-namespace allowed.