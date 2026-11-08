# Kubernetes Integration & Pod Management with Minikube and Docker

## Objectives
- Initialize and configure a local single-node Kubernetes development cluster using Minikube and the Docker driver.
- Build container images directly inside Minikube's Docker daemon (`eval $(minikube docker-env)`) to bypass external container registries.
- Deploy declarative multi-replica applications using Kubernetes Deployments and NodePort Services.
- Execute horizontal pod autoscaling and zero-downtime rolling updates (`kubectl set image`).

## Technology Stack
- Minikube & Kubernetes (`kubectl`)
- Docker Engine & Nginx Alpine
- Linux Bash Shell & YAML Manifests

## Key Skills Demonstrated
- **Local Container Orchestration:** Bridging native Docker workflows with Kubernetes pod lifecycles.
- **Declarative Deployments:** Managing replica sets, resource requests/limits (`cpu`/`memory`), and networking endpoints.
- **Lifecycle Operations:** Monitoring cluster events, scaling pods dynamically, and executing rolling version upgrades.
