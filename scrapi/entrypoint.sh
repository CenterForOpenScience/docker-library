#!/bin/bash
set -e

export HOME=/home

if [[ $(stat -c '%U' /code) != www-data ]]; then
    chown -R www-data:www-data /code
    gosu www-data git clone -b $SOURCE_BRANCH $SOURCE_REPO .
    gosu www-data ln -s /home/.cos/local.py /code/scrapi/settings/local.py
fi

gosu www-data git pull
pip install -U -r requirements.txt

exec gosu www-data "$@"
