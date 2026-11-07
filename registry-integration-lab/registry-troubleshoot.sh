#!/bin/bash
echo "Registry Troubleshooting Guide"
systemctl is-active docker
docker ps | grep registry || echo "No registry containers running"
if curl -s http://localhost:5000/v2/ > /dev/null; then
    echo "✓ Registry is accessible"
else
    echo "✗ Registry is not accessible"
fi
