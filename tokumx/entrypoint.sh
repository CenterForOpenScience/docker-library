#!/bin/bash
set -e

if [[ $(stat -c '%U' /data) != tokumx ]]; then
    chown -R tokumx /data
fi

exec gosu tokumx "$@"
