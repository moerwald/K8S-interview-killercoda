
### **Task 1: Create a Deployment**

Your first task is to deploy a simple Nginx web server.

**Requirements:**
-   Create a file named `deployment.yaml`.
-   The Deployment should be named `web-server`.
-   It should manage **2 replicas**.
-   The container image must be `nginx:1.25`.
-   The pods should have the label `app: web`.
-   The container should expose port `80`.

Once you have created the file, apply it to the cluster.

**Verification:**
You can verify your work by running:
`kubectl get deployment web-server`
`kubectl get pods -l app=web`

You should see the deployment and two running pods.
