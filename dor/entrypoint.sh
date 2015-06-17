#!/bin/bash
set -e

export HOME=/home/python
chown -R python ~/

if [[ $(stat -c '%U' /log) != python ]]; then
    chown python /log
fi

if [[ $(stat -c '%U' /code) != python ]]; then
    chown -R python /code
    gosu python git clone -b $SOURCE_BRANCH $SOURCE_REPO .
    gosu python ln -s ~/.cos/local.py /code/RepoDir/settings/local.py
fi

gosu python git pull
pip install -U -r requirements.txt
gosu python bower install --config.interactive=false
gosu python python manage.py collectstatic --noinput

touch /tmp/uwsgi.sock
chown o+w /tmp/uwsgi.sock

exec gosu root "$@"
