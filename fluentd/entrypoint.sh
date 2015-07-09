#!/bin/bash
set -e

if [ $FLUETND_GEMS != "" ]; then
    fluent-gem install $FLUENTD_GEMS
fi

exec gosu fluentd "$@"
