# Multi-Tier Microservice Architecture with Custom Docker Compose Networks

## Objectives
- Design and implement a secure multi-tier application stack enforcing network-layer isolation via custom Docker bridge subnets.
- Configure cross-network reverse proxy routing (Nginx) and inter-container DNS service discovery without exposing internal databases directly to the host.
- Implement robust data access layers, cache-aside patterns, database health checks, and dependency gates.
- Execute network partition fault injection and recovery diagnostics using container-native primitives.

## Architecture & Technology Stack
- **Ingress Layer:** Nginx Alpine Reverse Proxy (`frontend-net`, `backend-net`)
- **Application Layer:** Python Flask REST API running as a non-root user (`backend-net`, `data-net`)
- **Data & Caching Layer:** PostgreSQL 15 & Redis 7 (`data-net` with zero host port exposure)
- **Orchestration:** Docker Compose v2 with custom `/24` bridge subnets and persistent volumes

## Key Skills Demonstrated
- **Zero-Trust Network Isolation:** Restricting database access strictly to the internal data network, ensuring the ingress proxy cannot reach backend datastores directly.
- **Resilient Application Design:** Implementing exponential backoff retry loops, schema bootstrapping, and health-check dependency gates (`service_healthy`).
- **DevSecOps Best Practices:** Eliminating hardcoded credentials via environment variables, executing containers under non-root users, and isolating service boundaries.

## Troubleshooting & Failure Injection Log
- **Issue:** Upstream DNS resolution failures or 502 Bad Gateway errors when Nginx attempts to route to backend services.
  - **Resolution:** Verified explicit container network attachments and tested inter-container resolution using `docker compose exec proxy nslookup api`.
- **Issue:** Application crash-looping during startup before the database engine completes initialization.
  - **Resolution:** Implemented PostgreSQL native healthchecks (`pg_isready`) combined with Compose `condition: service_healthy` dependency gates on the API container.
