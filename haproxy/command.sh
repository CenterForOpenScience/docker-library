#!/bin/bash
# Credit: https://github.com/discordianfish/haproxy-docker/
set -e
PIDFILE="/tmp/haproxy.pid"

reload() {
  echo "Reloading config"
  haproxy -p $PIDFILE -f /usr/local/etc/haproxy/haproxy.cfg -sf $(cat $PIDFILE)
}

haproxy -p $PIDFILE -f /usr/local/etc/haproxy/haproxy.cfg

trap reload SIGHUP
while true
do
  sleep infinity & # blocks forever but still make sure bash
  wait || :        # executes reload trap. See:
done               # http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_12_02.html#sect_12_02_02
