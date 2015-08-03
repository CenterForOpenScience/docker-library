#!/bin/bash
set -e

chown -R www-data:www-data /home

if [[ $(stat -c '%U' /code) != www-data ]]; then
    chown -R www-data:www-data /code
fi

gosu www-data git init
gosu www-data git remote rm origin
gosu www-data git remote add origin $SOURCE_REPO
gosu www-data git fetch -q
gosu www-data git checkout $SOURCE_BRANCH
gosu www-data git pull origin $SOURCE_BRANCH

invoke requirements --release
gosu www-data invoke assets

if [ "$1" = 'invoke' ]; then
    exec gosu www-data "$@"
fi

exec gosu root "$@"
