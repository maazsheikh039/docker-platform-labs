#!/bin/bash
set -e
DOCKER_USERNAME="${1:-your-docker-username}"
IMAGE_TAG="${2:-latest}"
CONTAINER_NAME="docker-cicd-app-production"
PORT="80"

echo "Starting production deployment..."
docker pull $DOCKER_USERNAME/docker-cicd-app:$IMAGE_TAG
docker stop $CONTAINER_NAME 2>/dev/null || true
docker rm $CONTAINER_NAME 2>/dev/null || true

docker run -d \
  --name $CONTAINER_NAME \
  --restart always \
  -p $PORT:3000 \
  -e NODE_ENV=production \
  $DOCKER_USERNAME/docker-cicd-app:$IMAGE_TAG
echo "Production deployment completed successfully!"
