#!/bin/bash
set -e

export HOME=/home

if [[ $(stat -c '%U' /code) != www-data ]]; then
    chown -R www-data:www-data /code
    gosu www-data git clone -b $SOURCE_BRANCH $SOURCE_REPO .
fi

gosu www-data git pull
invoke requirements --release

exec gosu www-data "$@"
