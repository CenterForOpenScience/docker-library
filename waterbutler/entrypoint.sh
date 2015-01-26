#!/bin/bash
set -e

export HOME=/home/python

if [[ $(stat -c '%U' /data/osfstorage/pending) != python ]]; then
    chown python /data/osfstorage/pending
fi

if [[ $(stat -c '%U' /data/osfstorage/complete) != python ]]; then
    chown python /data/osfstorage/complete
fi

if [[ $(stat -c '%U' /log) != python ]]; then
    chown python /log
fi

chown -R python ~/.cos

git clone -q -b $SOURCE_BRANCH $SOURCE_REPO .
git pull
pip install -U -r requirements.txt
python setup.py develop
chown -R python /code

exec gosu python "$@"