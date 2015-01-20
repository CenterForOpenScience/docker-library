#!/bin/bash
set -e

export HOME=/home/python

if [[ $(stat -c '%U' /data/osfstorage/pending) != python ]]; then
    chown -R python /data/osfstorage/pending
fi

if [[ $(stat -c '%U' /data/osfstorage/complete) != python ]]; then
    chown -R python /data/osfstorage/complete
fi

chown -R python ~/.cos

git pull
pip install -U -r requirements.txt
python setup.py develop
chown -R python /code

exec gosu python "$@"