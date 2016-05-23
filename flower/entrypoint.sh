#!/bin/bash
set -e

if [ "$1" = 'flower' ]; then
	exec gosu nobody "$@"
fi

exec "$@"
