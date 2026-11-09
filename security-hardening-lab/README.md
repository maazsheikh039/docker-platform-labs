# Advanced Docker Security, Daemon Hardening & Automated Scanning Pipeline

## Objectives
- Configure a hardened Docker daemon enforcing user namespace remapping (`userns-remap`), inter-container communication isolation (`icc: false`), and default privilege drop controls.
- Construct a production-grade, multi-stage minimal container image using Alpine Linux, running entirely under a non-root user (UID 1001).
- Build a comprehensive, automated security scanning pipeline script (`scan-pipeline.sh`) integrating Trivy (CVE, secrets, config) and Dockle (CIS benchmarks) with strict exit-code gating.

## Technology Stack
- Docker Engine & Hardened Daemon Runtime
- Trivy Security Vulnerability Scanner & Dockle Linter
- Hadolint Dockerfile Linter & Linux Bash Automation

## Key Skills Demonstrated
- **Defense-in-Depth Container Architecture:** Securing the host runtime environment via user namespaces and enforcing least-privilege container execution.
- **Vulnerability Gating:** Implementing automated pipelines that block deployments containing HIGH or CRITICAL CVEs or unmasked secrets.
- **Auditing & Compliance:** Generating persistent audit artifacts (`reports/` and `dockerfile-audit.txt`) matching enterprise compliance requirements.
