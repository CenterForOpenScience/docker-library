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

git pull
pip install -U -r requirements.txt
bower install --allow-root --config.interactive=false
python manage.py collectstatic --noinput
chown -R python /code

exec gosu root "$@"
