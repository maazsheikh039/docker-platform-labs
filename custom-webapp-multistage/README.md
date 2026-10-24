# Containerized Python & Go Web Applications with Docker

Production-ready containerization lab demonstrating multi-stage Docker builds, non-root user security hardening, container networking, and filesystem change auditing.

## Objectives
- Build optimized, secure container images using single-stage and multi-stage Dockerfiles.
- Implement security best practices (non-root execution, healthchecks).
- Manage container lifecycles, resource constraints, and isolated bridge networks.
- Audit container changes using `docker diff` and commit container snapshots.

## Tools Used
- Docker Engine & Buildx
- Python 3.9 Slim & Golang Alpine Runtimes
- Linux (Ubuntu / Alpine)

## Key Skills Demonstrated
- **Multi-Stage Builds:** Minimized container attack surface and image footprint by separating build environments from final runtimes.
- **Security Hardening:** Enforced non-root user execution (`appuser`) and configured automated container health checks.
- **Container Networking:** Configured custom user-defined bridge networks for secure inter-container communication.
- **Resource Governance:** Applied hard memory (`128m`) and CPU (`0.5`) constraints on container workloads.

## Troubleshooting Log
- **Issue:** Permission denied when interacting with the Docker Unix socket.
  - **Resolution:** Added the user to the `docker` security group and refreshed group context using `newgrp docker`.
- **Issue:** Bloated image sizes in initial Python builds.
  - **Resolution:** Migrated to slim base images and optimized cache layer ordering during `COPY` steps.
