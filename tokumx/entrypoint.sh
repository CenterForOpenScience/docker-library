#!/bin/bash
set -e

if [[ $(stat -c '%U' /etc/ssl/private) != tokumx ]]; then
    chown -R tokumx:tokumx /etc/ssl/private
fi

if [ "${1:0:1}" = '-' ]; then
	set -- mongod "$@"
fi

if [ "$1" = 'mongod' ]; then
	chown -R tokumx /data/db

	numa='numactl --interleave=all'
	if $numa true &> /dev/null; then
		set -- $numa "$@"
	fi

	exec gosu tokumx "$@"
fi

exec "$@"
