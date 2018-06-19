#!/bin/bash

set -e

# Add cerebro as command if needed
if [ "${1:0:1}" = '-' ]; then
	set -- /opt/cerebro/bin/cerebro "$@"
fi

# Drop root privileges if we are running cerebro
# allow the container to be started with `--user`
if [ "$1" = 'bin/cerebro' -a "$(id -u)" = '0' ]; then
	# Change the ownership of user-mutable directories to cerebro
	for path in \
		/opt/cerebro \
	; do
		chown -R cerebro:cerebro "$path" || true
	done

	set -- gosu cerebro "$@"
fi

# As argument is not related to cerebro,
# then assume that user wants to run his own process,
# for example a `bash` shell to explore this image
exec "$@"