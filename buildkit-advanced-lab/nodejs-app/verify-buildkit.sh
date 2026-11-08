#!/bin/bash
echo "=== BuildKit Verification Tests ==="
docker info | grep -q "BuildKit" && echo "✓ BuildKit is enabled" || echo "✗ BuildKit is not enabled"
cd ~/buildkit-lab/nodejs-app
docker build -q -t test-cache . > /dev/null 2>&1 && echo "✓ Cache mount build successful" || echo "✗ Cache mount build failed"
cd ~/buildkit-lab/go-app
docker build -q -t test-multistage . > /dev/null 2>&1 && echo "✓ Multi-stage build successful" || echo "✗ Multi-stage build failed"
cd ~/buildkit-lab/nodejs-app
docker build --secret id=api_key,src=./api-key.txt -f Dockerfile.secrets -q -t test-secrets . > /dev/null 2>&1 && echo "✓ Secret mount build successful" || echo "✗ Secret mount build failed"
docker buildx version > /dev/null 2>&1 && echo "✓ Buildx is available" || echo "✗ Buildx is not available"
echo "=== Verification completed ==="
