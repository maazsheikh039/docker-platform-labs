#!/bin/bash
set -e

IMAGE_NAME="${1}"
if [ -z "$IMAGE_NAME" ]; then
  echo "Usage: bash scan-pipeline.sh <docker-image>"
  exit 1
fi

REPORT_DIR="reports"
mkdir -p "$REPORT_DIR"
SAFE_IMAGE_NAME=$(echo "$IMAGE_NAME" | tr '/' '_' | tr ':' '_')

echo "=================================================="
echo "Starting Automated Security Pipeline for: $IMAGE_NAME"
echo "=================================================="

# 1. Trivy CVE Scan (HIGH, CRITICAL)
echo "[*] Running Trivy CVE Vulnerability Scan..."
trivy image --severity HIGH,CRITICAL --format json -o "$REPORT_DIR/${SAFE_IMAGE_NAME}-cve.json" "$IMAGE_NAME"
CVE_HIGH_CRIT=$(trivy image --severity HIGH,CRITICAL --quiet "$IMAGE_NAME" | grep -E "Total: [0-9]+" | tail -n 1 || echo "0")
echo "-> CVE Report saved to $REPORT_DIR/${SAFE_IMAGE_NAME}-cve.json"

# 2. Trivy Secrets Scan
echo "[*] Running Trivy Secrets Scan..."
trivy image --scanners secret --format json -o "$REPORT_DIR/${SAFE_IMAGE_NAME}-secrets.json" "$IMAGE_NAME"
echo "-> Secrets Report saved to $REPORT_DIR/${SAFE_IMAGE_NAME}-secrets.json"

# 3. Trivy Misconfiguration Scan
echo "[*] Running Trivy Misconfiguration Scan..."
trivy image --scanners config --format json -o "$REPORT_DIR/${SAFE_IMAGE_NAME}-config.json" "$IMAGE_NAME"
echo "-> Misconfiguration Report saved to $REPORT_DIR/${SAFE_IMAGE_NAME}-config.json"

# 4. Dockle CIS Benchmark Scan
echo "[*] Running Dockle CIS Benchmark Scan..."
dockle -f json -o "$REPORT_DIR/${SAFE_IMAGE_NAME}-dockle.json" "$IMAGE_NAME" || true
echo "-> Dockle Report saved to $REPORT_DIR/${SAFE_IMAGE_NAME}-dockle.json"

echo "=================================================="
echo "Pipeline Scan Summary for $IMAGE_NAME:"
echo "=================================================="

# Count HIGH/CRITICAL CVE findings safely from Trivy JSON report
HIGH_COUNT=$(grep -o '"Severity":"HIGH"' "$REPORT_DIR/${SAFE_IMAGE_NAME}-cve.json" 2>/dev/null | wc -l || echo "0")
CRIT_COUNT=$(grep -o '"Severity":"CRITICAL"' "$REPORT_DIR/${SAFE_IMAGE_NAME}-cve.json" 2>/dev/null | wc -l || echo "0")
TOTAL_FAILURES=$((HIGH_COUNT + CRIT_COUNT))

echo " - High/Critical Vulnerabilities: $TOTAL_FAILURES (High: $HIGH_COUNT, Critical: $CRIT_COUNT)"
echo " - Secrets Findings: Check $REPORT_DIR/${SAFE_IMAGE_NAME}-secrets.json"
echo " - Config Findings: Check $REPORT_DIR/${SAFE_IMAGE_NAME}-config.json"
echo " - Dockle Findings: Check $REPORT_DIR/${SAFE_IMAGE_NAME}-dockle.json"
echo "=================================================="

if [ "$TOTAL_FAILURES" -gt 0 ]; then
  echo "[!] Pipeline FAILED: Found $TOTAL_FAILURES High/Critical vulnerabilities."
  exit 1
else
  echo "[+] Pipeline PASSED: Zero High/Critical vulnerabilities detected."
  exit 0
fi
