#!/bin/bash
set -e

export HOME=/home/python

if [[ "$1" = invoke-* ]]; then
    if [ "$1" = 'invoke-celery' ]; then
        echo "Starting Celery"
        exec gosu python bash -c "invoke celery"
    fi

    if [ "$1" = 'invoke-server' ]; then
        echo "Starting Server"
        exec gosu python bash -c "invoke server"
    fi
fi

exec gosu python bash -c "$@"
