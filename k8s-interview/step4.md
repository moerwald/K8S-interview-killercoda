# -------------------- step4.md --------------------
### **Task 4: Troubleshoot a Broken Deployment**

Another team has tried to deploy a simple Node.js application, but it's failing. They've provided you with the necessary files (`broken-app.js`, `package.json`) and a `Dockerfile`.

Your task is to:
1.  Create a Docker image for the application.
2.  Deploy it to Kubernetes.
3.  Identify why the pods are failing and fix the issue.

**Instructions:**
1.  Create a `Dockerfile` for the Node.js application.
    ```dockerfile
    FROM node:18-alpine
    WORKDIR /app
    COPY package.json .
    RUN npm install
    COPY broken-app.js .
    CMD ["node", "broken-app.js"]
    ```
2.  Build the Docker image and tag it as `broken-app:v1`.
    `docker build -t broken-app:v1 .`

3.  Create a new deployment file named `broken-deployment.yaml` for this app.
    -   Name: `broken-app`
    -   Replicas: 1
    -   Image: `broken-app:v1`
    -   **Important:** Set `imagePullPolicy: Never` since the image only exists locally.

4.  Apply the deployment and observe the pod status. It will enter a `CrashLoopBackOff` state.

**Your Goal:**
-   Investigate the pod using `kubectl logs` and `kubectl describe`.
-   Identify the bug in `broken-app.js`.
-   Correct the file, rebuild the Docker image (`docker build -t broken-app:v1 .`), and delete the failing pod so the deployment creates a new, working one.

**Verification:**
When fixed, the pod should be in a `Running` state. You can check the logs to see the "Server is running on port 3000" message.
`kubectl get pods`
`kubectl logs <your-new-pod-name>`