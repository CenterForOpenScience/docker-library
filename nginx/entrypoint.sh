#!/bin/bash
set -eu

render-templates.sh /etc/nginx/sites-templates /etc/nginx/conf.d

exec $@
