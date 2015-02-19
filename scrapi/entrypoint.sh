#!/bin/bash
set -e

export HOME=/home/python

if [[ $(stat -c '%U' /log) != python ]]; then
    chown python /log
fi

if [[ $(stat -c '%U' /code) != python ]]; then
    git clone -b $SOURCE_BRANCH $SOURCE_REPO .
fi

git pull
pip install -U -r requirements.txt
chown -R python /code

exec gosu python "$@"
