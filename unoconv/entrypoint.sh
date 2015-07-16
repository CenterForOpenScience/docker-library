#!/bin/bash
set -e

chown -R www-data:www-data /home

exec gosu www-data "$@"
