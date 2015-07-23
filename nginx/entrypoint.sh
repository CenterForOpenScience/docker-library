#!/bin/bash
set -eu

function fill_in() {
    perl -p -e 's/\$\{([^}]+)\}/defined $ENV{$1} ? $ENV{$1} : "\${$1}"/eg' "${1}"
}

fill_in /etc/nginx/nginx.conf > /etc/nginx/nginx.conf.tmp

exec "$@"
