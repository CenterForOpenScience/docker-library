#!/bin/bash
set -e

export HOME=/home/unoconv

if [[ $(stat -c '%U' /unoconv) != unoconv ]]; then
    chown unoconv /unoconv
fi

exec gosu unoconv "$@"
