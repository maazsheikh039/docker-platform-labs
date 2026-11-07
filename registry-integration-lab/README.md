# Enterprise Docker Registry Integration & Secure Private Storage

Production-grade container registry architecture lab covering public registry distribution via Docker Hub, self-hosted private registry deployment, Htpasswd basic authentication, and insecure daemon configurations.

## Objectives
- Configure public image distribution pipelines with Docker Hub using semantic tagging.
- Provision a standalone, self-hosted private container registry (`registry:2`).
- Implement basic authentication security layers using Apache Htpasswd credentials.
- Configure Docker daemon network exceptions for local HTTP-only container registries.

## Tools Used
- Docker Engine & Registry v2 API
- Apache Utils (`htpasswd`)
- Nginx Alpine Web Server

## Key Skills Demonstrated
- **Registry Provisioning:** Deployed and managed an isolated local private registry instance with persistent volume storage (`~/registry-data`).
- **Security Hardening:** Enforced basic HTTP authentication across registry endpoints to prevent unauthorized image pulls and pushes.
- **Daemon Configuration:** Configured Docker runtime security exceptions (`insecure-registries`) for seamless local certificate-free registry communication.
- **Lifecycle Operations:** Automated image tagging, catalog inspection via REST APIs, and multi-registry artifact synchronization.

## Troubleshooting Log
- **Issue:** `server gave HTTP response to HTTPS client` error when pushing images to the local private registry.
  - **Resolution:** Configured `/etc/docker/daemon.json` to include `"insecure-registries": ["localhost:5000"]` and restarted the Docker systemd daemon.
- **Issue:** Authentication failures (`unauthorized: authentication required`) when accessing private registry endpoints.
  - **Resolution:** Generated a valid bcrypt-encrypted `htpasswd` file and mounted it correctly into the registry container with environment variables pointing to its path.
