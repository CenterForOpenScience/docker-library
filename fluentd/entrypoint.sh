#!/bin/bash
set -e

if [[ $(stat -c '%U' /var/log) != fluentd ]]; then
    chown fluentd:fluentd /var/log
fi

if [ "$FLUENTD_GEMS" != "" ]; then
    fluent-gem install $FLUENTD_GEMS
fi

exec gosu fluentd "$@"
