#!/bin/bash
set -e

if [[ $(stat -c '%U' /log) != fluentd ]]; then
    chown fluentd:fluentd /log
fi

if [ "$FLUENTD_GEMS" != "" ]; then
    fluent-gem install $FLUENTD_GEMS
fi

exec gosu fluentd "$@"
