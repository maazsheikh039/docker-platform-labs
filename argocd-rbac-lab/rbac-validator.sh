#!/bin/bash
set -eo pipefail

SERVER="localhost:8080"
FAILED_CASES=0
TOTAL_CASES=0

login_as() {
    local username=$1
    local password=$2
    argocd login "$SERVER" --username "$username" --password "$password" --insecure >/dev/null 2>&1
}

restore_admin_session() {
    local admin_pass
    admin_pass=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode)
    argocd login "$SERVER" --username admin --password "$admin_pass" --insecure >/dev/null 2>&1
}

rbac_test_case() {
    local username=$1
    local password=$2
    local resource=$3
    local action=$4
    local object=$5
    local expected=$6

    TOTAL_CASES=$((TOTAL_CASES + 1))
    
    login_as "$username" "$password"
    
    # Use argocd account can-i API to evaluate permission
    local result
    result=$(argocd account can-i "$action" "$resource" "$object" 2>/dev/null || echo "no")
    
    # Normalize result
    if [ "$result" = "yes" ]; then
        actual="allow"
    else
        actual="deny"
    fi

    if [ "$actual" = "$expected" ]; then
        echo "CASE $TOTAL_CASES [$username | $action $resource $object] -> Expected: $expected, Got: $actual ... PASS"
    else
        echo "CASE $TOTAL_CASES [$username | $action $resource $object] -> Expected: $expected, Got: $actual ... FAIL"
        FAILED_CASES=$((FAILED_CASES + 1))
    fi
    
    restore_admin_session
}

rbac_run_suite() {
    echo "=================================================="
    echo "Running Argo CD RBAC Validation Suite"
    echo "=================================================="

    # Alice (developer) test cases
    rbac_test_case "alice" "AlicePass#2024" "applications" "get"    "team-alpha/guestbook-alpha" "allow"
    rbac_test_case "alice" "AlicePass#2024" "applications" "sync"   "team-alpha/guestbook-alpha" "allow"
    rbac_test_case "alice" "AlicePass#2024" "applications" "sync"   "team-beta/guestbook-beta"    "deny"
    rbac_test_case "alice" "AlicePass#2024" "applications" "create" "team-alpha/*"                "deny"
    rbac_test_case "alice" "AlicePass#2024" "applications" "delete" "team-alpha/*"                "deny"

    # Bob (devops) test cases
    rbac_test_case "bob"   "BobPass#2024"   "applications" "create" "team-alpha/*"                "allow"
    rbac_test_case "bob"   "BobPass#2024"   "applications" "delete" "team-alpha/*"                "allow"
    rbac_test_case "bob"   "BobPass#2024"   "repositories" "create" "*"                           "allow"
    rbac_test_case "bob"   "BobPass#2024"   "projects"     "create" "*"                           "deny"
    rbac_test_case "bob"   "BobPass#2024"   "clusters"     "delete" "*"                           "deny"

    # Charlie (org-admin) test cases
    rbac_test_case "charlie" "CharliePass#2024" "projects" "create" "*"                           "allow"
    rbac_test_case "charlie" "CharliePass#2024" "clusters" "delete" "*"                           "allow"

    echo "=================================================="
    echo "Test Suite Completed. Total: $TOTAL_CASES, Failed: $FAILED_CASES"
    echo "=================================================="

    if [ "$FAILED_CASES" -gt 0 ]; then
        exit 1
    else
        exit 0
    fi
}

rbac_run_suite
