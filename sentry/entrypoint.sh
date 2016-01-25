#!/bin/bash
set -e

chown -R www-data:www-data /var/lib/sentry/files || true

# first check if we're passing flags, if so
# prepend with sentry
if [ "${1:0:1}" = '-' ]; then
	set -- gosu www-data /docker-entrypoint.sh "$@"
fi

case "$1" in
	celery|cleanup|config|createuser|devserver|django|export|help|import|init|plugins|repair|shell|start|upgrade)
		set -- gosu www-data /docker-entrypoint.sh "$@"
	;;
esac

exec "$@"
