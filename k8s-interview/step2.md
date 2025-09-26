
### **Task 2: Expose the Deployment with a Service**

Now that the pods are running, you need to make them accessible within the cluster.

**Requirements:**
-   Create a file named `service.yaml`.
-   The Service should be named `web-service`.
-   It must be of type `NodePort`.
-   It should select pods with the label `app: web`.
-   It should expose port `80` and target the container's port `80`.

Apply the service manifest.

**Verification:**
1.  Check that the service was created: `kubectl get service web-service`
2.  Find the assigned NodePort and test it using `curl`. You can get the port with this command:
    `NODE_PORT=$(kubectl get svc web-service -o jsonpath='{.spec.ports[0].nodePort}')`
3.  Then, test the connection:
    `curl localhost:$NODE_PORT`

You should see the default "Welcome to nginx!" page.
