#!/bin/bash
echo "=== Docker Cleanup Script ==="
docker system df
echo "Cleaning up..."
docker image prune -f
docker container prune -f
docker network prune -f
docker volume prune -f
docker system df
