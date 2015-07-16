#!/bin/bash
set -e

chown -R www-data:www-data /home

if [[ $(stat -c '%U' /code) != www-data ]]; then
    chown -R www-data:www-data /code
    gosu www-data git clone -b $SOURCE_BRANCH $SOURCE_REPO .
fi

gosu www-data git pull
pip install -U -r requirements.txt
python setup.py develop

exec gosu www-data "$@"
