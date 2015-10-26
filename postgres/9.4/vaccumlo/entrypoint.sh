#!/bin/bash
set -e

echo "$CRON_TASK" | crontab -

exec "$@"
