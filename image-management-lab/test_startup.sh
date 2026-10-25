#!/bin/bash
echo "=== Startup Time Comparison ==="
for tag in latest optimized multistage advanced; do
    echo "Testing nodejs-lab-app:$tag"
    start_time=$(date +%s.%N)
    container_id=$(docker run -d -p 3000:3000 nodejs-lab-app:$tag)
    sleep 2
    if curl -s http://localhost:3000 > /dev/null; then
        end_time=$(date +%s.%N)
        startup_time=$(echo "$end_time - $start_time" | bc)
        echo "Startup time: ${startup_time}s"
    else
        echo "Failed to start"
    fi
    docker stop $container_id > /dev/null
    docker rm $container_id > /dev/null
    echo "---"
done
