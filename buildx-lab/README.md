# Cross-Platform Multi-Architecture Container Builds with Docker Buildx

## Objectives
- Set up Docker Buildx container driver instances alongside QEMU static binary emulation for heterogeneous compilation.
- Build, tag, and publish multi-architecture container images supporting both `linux/amd64` and `linux/arm64` targets.
- Inspect container image manifests using `docker buildx imagetools` and verify cross-platform execution behavior.

## Technology Stack
- Docker Engine & Docker Buildx
- QEMU User Static Emulation
- Node.js (Express) Multi-Stage Dockerfiles

## Key Skills Demonstrated
- **Heterogeneous Compilation:** Leveraging Buildx matrix builders to produce single unified image manifests for diverse processor architectures (e.g., AWS Graviton and Apple Silicon).
- **Emulated Validation:** Utilizing QEMU kernel hooks to test and verify ARM64 binaries on x86_64 host infrastructure.
- **Registry Manifest Management:** Inspecting and managing multi-platform image indexes without separate tagging overhead.
