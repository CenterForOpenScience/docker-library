#!/bin/bash
set -e

chown -R www-data:www-data /home

if [[ $(stat -c '%U' /code) != www-data ]]; then
    chown -R www-data:www-data /code
    gosu www-data git clone -b $SOURCE_BRANCH $SOURCE_REPO .
    gosu www-data ln -s /home/.cos/local.py /code/shareregistration/settings/local.py
fi

gosu www-data git pull
pip install -U -r requirements.txt
gosu www-data npm install --production
gosu www-data bower install --config.interactive=false
gosu www-data python manage.py collectstatic --noinput

exec gosu root "$@"
