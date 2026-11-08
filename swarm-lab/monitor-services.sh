#!/bin/bash
echo "=== Docker Swarm Status ==="
docker info | grep -A 5 "Swarm:"
echo
echo "=== Node Information ==="
docker node ls
echo
echo "=== Stack Information ==="
docker stack ls
echo
echo "=== Service Status ==="
docker service ls
echo
