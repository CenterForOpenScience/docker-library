#!/bin/bash
set -e

export HOME=/home/python
chown -R python ~/

if [[ $(stat -c '%U' /log) != python ]]; then
    chown python /log
fi

if [[ $(stat -c '%U' /code) != python ]]; then
    git clone -b $SOURCE_BRANCH $SOURCE_REPO .
    ln -s ~/.cos/local.py /code/RepoDir/settings/local.py
    chown python /code
fi

gosu python git pull
pip install -U -r requirements.txt
gosu python bower install --config.interactive=false
gosu python python manage.py collectstatic --noinput

exec gosu root "$@"
