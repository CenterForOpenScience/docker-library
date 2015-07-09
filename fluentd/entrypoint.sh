#!/bin/bash
set -e

if [ "$FLUENTD_GEMS" != "" ]; then
    fluent-gem install $FLUENTD_GEMS
fi

exec gosu fluentd "$@"
