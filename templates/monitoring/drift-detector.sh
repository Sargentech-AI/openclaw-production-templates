#!/bin/bash
# Drift Detector — catch when cron jobs silently switch models
#
# Problem: When a local model provider goes down, OpenClaw may fall back to
# expensive cloud models. Without monitoring, you won't know until the bill arrives.
#
# Usage: Run via cron every 30 minutes, or as a heartbeat check.
#
# Requires: OpenClaw logs at /tmp/openclaw/

LOG_DIR="/tmp/openclaw"
TODAY=$(date +%Y-%m-%d)
LOG_FILE="$LOG_DIR/openclaw-$TODAY.log"

if [ ! -f "$LOG_FILE" ]; then
  echo "No log file for today"
  exit 0
fi

# Count model drift events
DRIFT_COUNT=$(grep -c "live session model switch" "$LOG_FILE" 2>/dev/null || echo 0)

if [ "$DRIFT_COUNT" -gt 0 ]; then
  echo "⚠️ MODEL DRIFT DETECTED: $DRIFT_COUNT events today"
  echo ""
  echo "Recent drift events:"
  grep "live session model switch" "$LOG_FILE" | tail -5
  echo ""
  echo "Action: Check provider health and cron model assignments"
  exit 1
else
  echo "✅ No model drift detected today"
  exit 0
fi
