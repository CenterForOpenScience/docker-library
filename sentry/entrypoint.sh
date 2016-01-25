#!/bin/bash
set -e

# chown -R www-data:www-data /home || true
# chown -R www-data:www-data /code || true

exec gosu www-data /docker-entrypoint.sh "$@"
