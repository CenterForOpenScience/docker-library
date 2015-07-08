#!/bin/bash
set -e

if [[ $(stat -c '%U' /data) != tokumx ]]; then
    chown -R tokumx /data
fi

if [[ $(stat -c '%U' /log) != tokumx ]]; then
    chown -R tokumx /log
fi

exec gosu tokumx "$@"
