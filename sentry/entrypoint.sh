#!/bin/bash
set -e

chown -R sentry:sentry /var/lib/sentry/files || true

case "$1" in
	celery|cleanup|config|createuser|devserver|django|export|help|import|init|plugins|repair|shell|start|upgrade)
		set -- gosu sentry /docker-entrypoint.sh "$@"
	;;
esac

exec "$@"
