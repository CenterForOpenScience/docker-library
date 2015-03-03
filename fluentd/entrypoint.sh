#!/bin/bash
set -e

if [ -z "$FLUETND_GEMS" ]; then
    fluent-gem install $FLUENTD_GEMS
fi

exec gosu fluentd "$@"
