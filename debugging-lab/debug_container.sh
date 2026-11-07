#!/bin/bash
if [ $# -eq 0 ]; then
    echo "Usage: $0 <container_name>"
    exit 1
fi
CONTAINER=$1
echo "=== Container Debug Report for: $CONTAINER ==="
echo "Generated at: $(date)"
echo "=== State & Exit Code ==="
docker inspect --format='Status: {{.State.Status}} | ExitCode: {{.State.ExitCode}}' $CONTAINER 2>/dev/null || echo "Container not found"
echo "=== Recent Logs ==="
docker logs --tail 10 $CONTAINER 2>/dev/null
echo "=== Resource Usage ==="
docker stats --no-stream $CONTAINER 2>/dev/null
echo "=== End of Report ==="
