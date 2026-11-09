# Production-Grade Multi-Tier RBAC in Argo CD

## Objectives
- Design and enforce a robust multi-tier RBAC policy matrix separating permissions across Developer, DevOps, and Org-Admin roles using Casbin.
- Provision project isolation (`team-alpha` and `team-beta`) mapped to dedicated Kubernetes namespaces (`alpha-ns` and `beta-ns`).
- Implement an automated validation harness (`rbac-validator.sh`) utilizing the Argo CD `can-i` API to test positive and negative access boundaries.
- Audit policy decisions via structured JSON server debug logs and verify privilege boundaries.

## Technology Stack
- Minikube Kubernetes Cluster & kubectl
- Argo CD Controller, Repo Server, & API Server (v2.x)
- Casbin Policy Engine & Linux Bash Automation

## Key Skills Demonstrated
- **Declarative Access Control:** Configuring custom roles, user mappings, and fallback policies (`policy.default`) via Kubernetes ConfigMaps (`argocd-cm` and `argocd-rbac-cm`).
- **Least-Privilege Scoping:** Restricting developer synchronization capabilities strictly to assigned AppProjects (`team-alpha/*`) while barring cross-tenant modifications.
- **Compliance & Auditing:** Capturing structured enforcement logs and testing access controls programmatically.
