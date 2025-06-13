#!/bin/bash

set -euo pipefail

echo "🧹 Docker Log Cleanup Started at $(date)"

# Find all container logs
LOG_FILES=$(sudo find /var/lib/docker/containers/ -name "*-json.log")

if [ -z "$LOG_FILES" ]; then
    echo "✅ No logs found to truncate."
    exit 0
fi

# Optional: Report disk usage before
echo "📦 Space used by container logs before cleanup:"
sudo du -ch $LOG_FILES | grep total

# Truncate each log file
for file in $LOG_FILES; do
    echo "→ Truncating $file"
    sudo truncate -s 0 "$file"
done

# Optional: Report disk usage after
echo "📉 Space used by container logs after cleanup:"
sudo du -ch $LOG_FILES | grep total

echo "✅ Docker Log Cleanup Complete."

