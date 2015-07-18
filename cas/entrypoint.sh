#!/bin/bash
set -e

chown -R www-data:www-data /home

if [[ $(stat -c '%U' /cas-overlay) != www-data ]]; then
    chown -R www-data:www-data /cas-overlay
    gosu www-data git clone -b $SOURCE_BRANCH $SOURCE_REPO .
fi

gosu www-data git pull
gosu www-data mvn clean install

exec gosu www-data "$@"
