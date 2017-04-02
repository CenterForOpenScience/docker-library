#!/bin/bash
set -e

chown -R barman:barman /var/lib/barman || true

exec "$@"
