# Production-Grade Dockerfile Optimization & Security Hardening

Advanced containerization lab focusing on image footprint reduction via multi-stage builds, non-root user security hardening, health-check monitoring, and strict runtime container isolation.

## Objectives
- Construct naive baseline containers and measure baseline size and layer overhead.
- Implement multi-stage Docker builds to decouple build-time compilers and dev dependencies from production runtimes.
- Harden Python Flask and TypeScript applications with non-root security compliance (`appuser`/`nodejs`).
- Enforce strict runtime container security controls (`--read-only`, `--cap-drop ALL`, `--no-new-privileges`).

## Tools Used
- Docker Engine & Buildx
- Node.js 18 (Alpine & Default)
- Python 3.11 Slim & Gunicorn
- TypeScript Compiler (`tsc`)

## Key Skills Demonstrated
- **Footprint Optimization:** Slashed container image sizes by over 80% (from ~1GB down to under 190MB) using multi-stage alpine base images.
- **Security Hardening:** Enforced non-root user execution and container health-checks (`HEALTHCHECK`) for automated orchestration monitoring.
- **Runtime Isolation:** Secured running containers against privilege escalation and unauthorized root filesystem modifications using read-only rootfs flags and tmpfs mounts.
- **Layer Minimization:** Optimized instruction ordering and clean-up caching to reduce attack surfaces and vulnerability vectors.

## Troubleshooting Log
- **Issue:** Permission denied errors when writing temporary application logs during `--read-only` container execution.
  - **Resolution:** Configured an explicit tmpfs mount (`--tmpfs /tmp`) to provide a secure, ephemeral writable scratch space without compromising the read-only root filesystem.
- **Issue:** Health check failing due to application startup delay before binding to the network port.
  - **Resolution:** Adjusted the `--start-period` parameter in the Dockerfile `HEALTHCHECK` directive to give the runtime sufficient initialization time.
