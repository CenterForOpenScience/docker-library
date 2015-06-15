#!/bin/bash
set -e

export HOME=/home/unoconv

if [[ $(stat -c '%U' /unoconv) != unoconv ]]; then
    chown unoconv /unoconv
fi

if [[ $(stat -c '%U' /log) != unoconv ]]; then
    chown unoconv /log
fi

exec gosu unoconv "$@"
