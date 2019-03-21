#!/bin/bash
set -e

chown -R jenkins:jenkins /var/jenkins_home || true

if [ "$1" = '/bin/tini' ]; then
    echo "Starting: $@"
    exec gosu jenkins "$@"
fi

exec gosu root "$@"
