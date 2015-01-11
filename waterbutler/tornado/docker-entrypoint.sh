#!/bin/bash
set -e

if [ "$1" = 'tornado-server' ]; then
    su tornado -c "
        git pull
        git reset --hard 04df0857b34fa3f9b14491067c169b7c17132408
    "

    pip install --upgrade -r requirements.txt

    echo "Starting Tornado"
    exec su tornado -c "invoke server"
fi

exec su tornado -c "$@"
