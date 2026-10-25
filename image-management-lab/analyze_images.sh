#!/bin/bash
echo "=== Docker Image Analysis ==="
echo
echo "All nodejs-lab-app images:"
docker images | grep nodejs-lab-app | sort -k3

echo
echo "=== Size Comparison ==="
for tag in latest optimized multistage advanced; do
    if docker images nodejs-lab-app:$tag &> /dev/null; then
        size=$(docker images nodejs-lab-app:$tag --format "{{.Size}}")
        echo "nodejs-lab-app:$tag - $size"
    fi
done

echo
echo "=== Layer Analysis ==="
docker history nodejs-lab-app:multistage --no-trunc
