#!/bin/bash
echo "=== Build Performance Comparison ==="
cd ~/buildkit-lab/nodejs-app
export DOCKER_BUILDKIT=0
time docker build -f Dockerfile.traditional -t perf-test:traditional . 2>&1 | grep real

export DOCKER_BUILDKIT=1
time docker build -t perf-test:buildkit . 2>&1 | grep real
time docker build -t perf-test:buildkit-cached . 2>&1 | grep real
echo "=== Performance test completed ==="
