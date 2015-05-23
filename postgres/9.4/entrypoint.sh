#!/bin/bash
set -e

export HOME=/home/postgres

if [[ $(stat -c '%U' /log) != postgres ]]; then
    chown postgres /log
fi

exec "$@"
