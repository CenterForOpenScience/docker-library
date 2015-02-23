#!/bin/bash
set -e

exec gosu fluentd "$@"
