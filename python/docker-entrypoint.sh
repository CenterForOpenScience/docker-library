#!/bin/bash
set -e

if [ "$1" = 'python' ]; then
	chown -R python /code
	exec gosu python bash -c "$@"
fi

exec gosu python bash -c "$@"
