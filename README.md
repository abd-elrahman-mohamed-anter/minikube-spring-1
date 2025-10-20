
# Kubernetes Spring Boot Deployment

This project demonstrates the deployment and monitoring of a **Spring Boot** application (PetClinic) in a **Kubernetes** environment using `minikube`. It includes **Spring Boot Actuator** for health checks and exposes the application locally using **port-forwarding**.

---

## Project Structure

- `deploy.yaml` : Defines the **Deployment** for the Spring Boot application.
- `svc.yaml` : Defines a **NodePort Service** for accessing the application.
- `deploy.sh` : Script to deploy the application and start **port-forwarding**.
- `screenshots/` : Folder containing screenshots illustrating each stage of deployment and monitoring.

---

## Deployment Steps

1. Run the deployment script:

```bash
./deploy.sh
````

2. The script will:

   * Apply the **Deployment** and **Service** manifests in Kubernetes.
   * Wait 30 seconds for the **Pods** to be ready.
   * Start **port-forwarding** from local port `8081` to pod port `8080`.
   * Display the application and Actuator endpoint:

```
Access your app at: http://127.0.0.1:8081/actuator/health
```

---

## Screenshots

### 1. `screenshots/script.png`

Shows the execution of `./deploy.sh`, creation of **Deployment** and **Service**, and starting **port-forward**.

### 2. `screenshots/all.png`

Shows the status of Kubernetes resources using:

```bash
kubectl get all -o wide
```

* All Pods are running successfully.
* NodePort Service is ready.
* Health check via Actuator shows:

```json
{"status":"UP","groups":["liveness","readiness"]}
```

### 3. `screenshots/actuator.png`

Accessing the Spring Boot Actuator health endpoint:

```
http://127.0.0.1:8081/actuator/health
```

Indicates that the application status is **UP**.

### 4. `screenshots/spring.png`

Shows the frontend of the **Spring PetClinic** application after port-forwarding.

### 5. `screenshots/dash1.png` and `dash2.png`

Kubernetes Dashboard screenshots:

* `dash1.png` : Overview of **Workloads** and Deployment.
* `dash2.png` : Detailed view of Pods and ReplicaSets, confirming 3 Pods running.

---

## Notes

* The project uses **liveness** and **readiness probes** for Pod health:

```yaml
livenessProbe:
  httpGet:
    path: /actuator/health
    port: 8080
  initialDelaySeconds: 30
  periodSeconds: 10

readinessProbe:
  httpGet:
    path: /actuator/health
    port: 8080
  initialDelaySeconds: 10
  periodSeconds: 5
```

* You can access the application locally via:

```
http://127.0.0.1:8081
```

---

## Running Kubernetes Dashboard

To launch the **Kubernetes Dashboard** in minikube:

```bash
minikube dashboard
```

Navigate to the **Workloads** section to monitor Deployments and Pods.

---

## License

Educational project.

```

