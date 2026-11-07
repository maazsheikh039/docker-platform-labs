# Enterprise Docker Security Best Practices & Hardening Suite

Production-grade container security hardening lab covering user namespace remapping, custom Seccomp system call restriction filters, AppArmor mandatory access control policies, Docker Scout vulnerability scanning, and strict container resource governance.

## Objectives
- Enforce non-root execution mapping using Linux user namespaces (`userns-remap`).
- Restrict malicious system calls inside containers using customized JSON Seccomp profiles.
- Implement mandatory access control boundaries via custom AppArmor confinement policies.
- Audit container images for Common Vulnerabilities and Exposures (CVEs) using Docker Scout.
- Mitigate denial-of-service vectors by enforcing strict memory, CPU, process (`pids-limit`), and read-only rootfs constraints.

## Tools Used
- Docker Engine & Docker Scout
- Linux AppArmor & Seccomp Kernel Subsystems
- Apache Utils & Python Resource Benchmarks

## Key Skills Demonstrated
- **Kernel Isolation:** Configured user namespace remapping to ensure container root users map to unprivileged users (`dockeruser`) on the host system.
- **System Call Auditing:** Built strict Seccomp white-lists to block dangerous kernel calls like `mount` while permitting normal application operations.
- **Vulnerability Management:** Scanned, compared, and remediated base image vulnerabilities between outdated (`ubuntu:18.04`) and hardened (`ubuntu:22.04`) build configurations.
- **Resource Governance:** Provisioned hardened runtime profiles combining memory ceilings, CPU quotas, dropped Linux capabilities (`--cap-drop=ALL`), and ephemeral tmpfs mounts.

## Troubleshooting Log
- **Issue:** AppArmor profile parser failure during custom profile loading on newer kernel versions.
  - **Resolution:** Ensured proper profile headers (`#include <tunables/global>`) and flag declarations (`flags=(attach_disconnected,mediate_deleted)`) were included before reloading with `apparmor_parser -r`.
- **Issue:** Container permission errors when writing temporary cache files under `--read-only` rootfs flags.
  - **Resolution:** Provisioned secure, ephemeral storage partitions using restrictive tmpfs mounts (`--tmpfs /tmp:rw,noexec,nosuid,size=100m`).
