## Task 02 — Ingress (namespace `t2`)

Expose the app at `http://web.local/` via nginx Ingress.

**Commands**

```bash
kubectl create ns t2
kubectl -n t2 apply -f /root/killercoda/assets/deploy.yaml
kubectl -n t2 apply -f /root/killercoda/assets/ingress.yaml
kubectl -n ingress-nginx get pods
kubectl -n t2 get ingress
# Test from a pod:
kubectl -n t2 run dbg --image=busybox:1.36 --restart=Never -it -- sh -c "wget -qO- http://web"
```

> For host header testing from the node, add `web.local` to `/etc/hosts` (optional in this environment).