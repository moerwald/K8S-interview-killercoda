# -------------------- step3.md --------------------
### **Task 3: Customize the Welcome Page**

We want to serve a custom welcome page instead of the default Nginx page. A file named `welcome.html` has been placed in your home directory (`/root`).

**Requirements:**
1.  Create a **ConfigMap** named `web-content` from the file `/root/welcome.html`.
2.  **Modify your `deployment.yaml`** to mount this ConfigMap into the Nginx pods.
    -   The content of the ConfigMap should replace the default `index.html` at `/usr/share/nginx/html/index.html`.
3.  Re-apply your modified deployment.

**Hints:**
-   You'll need to add `volumes` and `volumeMounts` sections to your Deployment spec.
-   The `subPath` property in `volumeMounts` is very useful for mounting a single file.

**Verification:**
After the pods have been updated, run the `curl` command from the previous step again. You should now see the content from the `welcome.html` file.

`NODE_PORT=$(kubectl get svc web-service -o jsonpath='{.spec.ports[0].nodePort}') && curl localhost:$NODE_PORT`
