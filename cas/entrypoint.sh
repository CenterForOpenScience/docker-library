#!/bin/bash
set -e

export HOME=/home/cas

if [[ $(stat -c '%U' /log) != cas ]]; then
    chown cas /log
fi

if [[ $(stat -c '%U' /cas-overlay) != cas ]]; then
    git clone -b $SOURCE_BRANCH $SOURCE_REPO .
    # ln -s ~/.cos/local.py /cas-overlay/settings/local.py
fi

chown -R cas ~/.cos
chown -R cas /cas-overlay

gosu cas git pull
gosu cas mvn clean install

exec gosu cas "$@"
