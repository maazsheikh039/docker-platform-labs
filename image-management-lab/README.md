# Docker Image Management, Multi-Stage Optimization & Registry Operations

Production-grade container image management lab covering semantic tagging, Docker Hub synchronization, `.dockerignore` context minimization, multi-stage alpine builds, and automated system disk pruning.

## Objectives
- Tag images using semantic versioning (`1.0.0`, `latest`, `dev`) and push/pull artifacts to registries.
- Minimize build contexts and image footprints using strict `.dockerignore` configurations.
- Implement multi-stage builds (`deps` to `runner`) separating build dependencies from minimal production runtimes.
- Enforce security best practices via non-root user execution (`nodejs`) and automated disk cleanup scripts.

## Tools Used
- Docker Engine & Buildx
- Node.js 18 (Alpine Base)
- Docker Hub Registry
- Linux Shell Utilities

## Key Skills Demonstrated
- **Size Optimization:** Slashed container sizes significantly by combining multi-stage layering with Alpine Linux and `.dockerignore` cache exclusions.
- **Registry Management:** Configured multi-tag distribution pipelines for versioned releases and development branches.
- **Security Hardening:** Eliminated root execution privileges inside containers by provisioning dedicated system users (`nodejs`).
- **Maintenance Automation:** Authored automated disk maintenance scripts (`cleanup_docker.sh`) to prune dangling layers, stopped containers, and unused volumes.

## Troubleshooting Log
- **Issue:** Permission denied errors when executing push operations to remote registries.
  - **Resolution:** Authenticated against Docker Hub using `docker login` and verified repository namespace prefix alignment (`yourusername/repo:tag`).
- **Issue:** Excessive build context transmission causing slow image build times.
  - **Resolution:** Implemented a comprehensive `.dockerignore` file to exclude local `node_modules`, `logs`, temporary caches, and git metadata.
