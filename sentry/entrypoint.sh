#!/bin/bash
set -e

case "$1" in
	celery|cleanup|config|createuser|devserver|django|export|help|import|init|plugins|repair|shell|start|upgrade)
		set -- gosu www-data /docker-entrypoint.sh "$@"
	;;
esac

exec "$@"
