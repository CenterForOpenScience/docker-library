#!/bin/bash
set -e

chown -R haproxy /etc/ssl/private
chmod -R 640 /etc/ssl/private

exec "$@"
