#!/bin/bash
set -e

if [ "$1" = "mongod" ]; then
    chown -R tokumx /data/db
fi

exec gosu tokumx "$@"
