#!/bin/bash
set -e

if [[ $(stat -c '%U' /etc/cassandra) != cassandra ]]; then
    chown -R cassandra /etc/cassandra
fi

if [[ $(stat -c '%U' /var/lib/cassandra) != cassandra ]]; then
    chown -R cassandra /var/lib/cassandra
fi

exec gosu cassandra /docker-entrypoint.sh "$@"
