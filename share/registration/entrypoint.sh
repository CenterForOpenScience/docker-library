#!/bin/bash
set -e

export HOME=/home/python

if [[ $(stat -c '%U' /log) != python ]]; then
    chown python /log
fi

chown -R python ~/.cos

if [[ $(stat -c '%U' /code) != python ]]; then
    git clone -b $SOURCE_BRANCH $SOURCE_REPO .
    ln -s ~/.cos/local.py /code/shareregistration/settings/local.py
    chown -R python /code
fi

git pull
pip install -U -r requirements.txt
npm install --production
bower install --allow-root --config.interactive=false
python manage.py collectstatic --noinput
chown -R python /code

exec gosu root "$@"
