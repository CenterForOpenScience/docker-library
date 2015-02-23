#!/bin/bash
set -e

if [ "$1" = 'fluentd' ]; then
    chown -R fluentd /data/db
fi

exec gosu fluentd "$@"
