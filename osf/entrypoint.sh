#!/bin/bash
set -e

export HOME=/home

if [[ $(stat -c '%U' /code) != www-data ]]; then
    chown -R www-data:www-data /code
    gosu www-data git remote rm origin
    gosu www-data git remote add origin $SOURCE_REPO
    gosu www-data git fetch -q
    gosu www-data git checkout $SOURCE_BRANCH
fi

gosu www-data git pull
invoke requirements --release
gosu www-data invoke assets

exec gosu www-data "$@"
