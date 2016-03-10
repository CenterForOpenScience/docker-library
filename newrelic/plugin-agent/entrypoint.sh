#!/bin/bash
set -e

chown -R newrelic:newrelic /etc/newrelic || true

exec gosu root "$@"
