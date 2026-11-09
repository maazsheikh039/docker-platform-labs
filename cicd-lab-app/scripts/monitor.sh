#!/bin/bash
CONTAINER_NAME="${1:-docker-cicd-app-production}"
echo "Monitoring container: $CONTAINER_NAME"
docker ps --filter "name=$CONTAINER_NAME" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
docker logs --tail 20 $CONTAINER_NAME
