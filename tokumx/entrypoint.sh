#!/bin/bash
set -e

# Disable huge pages (requires privileged container)
echo never > /sys/kernel/mm/transparent_hugepage/enabled

if [ "$1" = 'mongod' ]; then
    chown -R tokumx /data/db
    exec gosu tokumx "$@"
fi

exec gosu tokumx "$@"
