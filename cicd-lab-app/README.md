# Automated CI/CD Pipeline with GitHub Actions and Docker

## Objectives
- Configure automated GitHub Actions workflows for continuous integration and multi-platform Docker builds (`linux/amd64`, `linux/arm64`).
- Securely authenticate and push container images to Docker Hub using repository secrets.
- Implement automated deployment scripts, health checking, container monitoring, and local orchestration with Docker Compose.

## Technology Stack
- GitHub Actions & GitHub CLI (`gh`)
- Docker Engine, Buildx, & Docker Hub Registry
- Node.js (Express) & Linux Bash Automation

## Key Skills Demonstrated
- **Pipeline Automation:** Defining robust YAML CI/CD workflows encompassing automated testing, matrix builds, and continuous deployment.
- **Security & Secrets Management:** Safely managing registry credentials (`DOCKER_USERNAME`, `DOCKER_PASSWORD`) via GitHub Actions encrypted secrets.
- **Operational Reliability:** Implementing container health validations, restart policies, and structured deployment tooling.
