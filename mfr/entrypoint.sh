#!/bin/bash
set -e

export HOME=/home/python

if [[ $(stat -c '%U' /log) != python ]]; then
    chown python /log
fi

chown -R python ~/.cos

if [[ $(stat -c '%U' /code) != python ]]; then
    git clone -b $SOURCE_BRANCH $SOURCE_REPO .
    chown -R python /code
fi

git pull
pip install -U -r requirements.txt
python setup.py develop
chown -R python /code

# ensure unoconv can locate the uno library
export PYTHONPATH=${PYTHONPATH}:/usr/lib/python3/dist-packages

exec gosu python "$@"
