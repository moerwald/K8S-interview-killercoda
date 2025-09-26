## Task 03 — Config & Secrets (namespace `t3`)

Externalize configuration using a ConfigMap and Secret. The app should print them.

**Commands**

```bash
kubectl create ns t3
kubectl -n t3 apply -f /root/killercoda/assets/config-secrets.yaml
kubectl -n t3 port-forward svc/web 18080:80 >/dev/null 2>&1 &
sleep 2 && curl -s http://127.0.0.1:18080/ | head -n 5
```

**What to check**

- Output contains GREETING and API_KEY values.
- Candidate mentions Secrets are base64 by default (not encrypted without KMS).