#!/bin/bash
echo "Registry Maintenance Script"
echo "Current repositories:"
curl -s -u registryuser:registrypass http://localhost:5000/v2/_catalog | python3 -m json.tool
echo "Storage usage:"
du -sh ~/registry-data
