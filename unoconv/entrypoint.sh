#!/bin/bash
set -e

chown -R www-data:www-data /home

if [[ $(stat -c '%U' /unoconv) != www-data ]]; then
    chown www-data:www-data /unoconv
fi

if [[ $(stat -c '%U' /log) != www-data ]]; then
    chown www-data:www-data /log
fi

exec gosu www-data "$@"
