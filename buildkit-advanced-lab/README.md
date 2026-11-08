# Advanced Container Optimization with Docker BuildKit

## Objectives
- Enable and configure Docker BuildKit globally and per-session.
- Implement cache mounts (`--mount=type=cache`) and bind mounts for high-performance dependency management.
- Securely handle build-time secrets (`--mount=type=secret`) preventing leakage into final image layers.
- Build production-ready multi-stage container images for Node.js and Go applications.
- Leverage BuildKit parallel stage execution and configure automated builder garbage collection.

## Tools Used
- Docker Engine & Docker Buildx
- Node.js / Express / Lodash
- Go (Golang) 1.21
- Docker Compose & Linux Bash Scripting

## Key Skills Demonstrated
- **Container Build Optimization:** Reducing build latency from minutes to seconds via intelligent layer caching.
- **Security Engineering:** Securely injecting API keys and credentials into ephemeral build runtimes without exposure in image history.
- **Multi-Stage Compilation:** Stripping heavy compilation toolchains from production runtimes to minimize image footprints.

## Troubleshooting Log
- **Issue:** Frequent cache invalidation during Node.js dependency installation when copying application code prior to package manifests.
  - **Resolution:** Restructured Dockerfile instructions to copy `package.json` and run `npm ci` with cache mounts prior to copying source code.
- **Issue:** Stale build cache bloating disk utilization on long-running build nodes.
  - **Resolution:** Configured automated daemon garbage collection policies in `/etc/docker/daemon.json` and established periodic `docker builder prune` cron cycles.
