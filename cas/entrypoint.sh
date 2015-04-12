#!/bin/bash
set -e

export HOME=/home/cas

if [[ $(stat -c '%U' /cas-overlay) != cas ]]; then
    git clone -b $SOURCE_BRANCH $SOURCE_REPO .
    # ln -s ~/.cos/local.py /cas-overlay/settings/local.py
    mvn clean
    mvn install
    mvn package
fi

chown -R cas ~/.cos
chown -R cas /cas-overlay

exec gosu cas "$@"
