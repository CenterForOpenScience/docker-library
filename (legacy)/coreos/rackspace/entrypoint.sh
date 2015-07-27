#!/bin/bash
set -e

export HOME=/home/python

chown -R python /code

exec gosu python invoke "$@"
