#!/bin/bash
set -e

CRON_TASK="$SCHEDULE bash vacuumlo"

if [ ! -z "$DB_HOST" ]; then
    CRON_TASK="$CRON_TASK -h $DB_HOST"
fi

if [ ! -z "$DB_PORT" ]; then
    CRON_TASK="$CRON_TASK -p $DB_PORT"
fi

if [ ! -z "$DB_USER" ]; then
    CRON_TASK="$CRON_TASK -U $DB_USER"
fi

if [ ! -z "$DB_PASSWORD" ]; then
    CRON_TASK="$CRON_TASK -w"
    echo "*:*:*:*:$DB_PASSWORD" > ~/.pgpass
    chmod 600 ~/.pgpass
fi

CRON_TASK="$CRON_TASK $DB_NAME"

echo "$CRON_TASK" | crontab -

exec "$@"
