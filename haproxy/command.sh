#!/bin/bash
# Credit: https://github.com/discordianfish/haproxy-docker/
set -e
PIDFILE="/tmp/haproxy.pid"

reload() {
  echo "Reloading config"
  haproxy -p $PIDFILE -f /usr/local/etc/haproxy/haproxy.cfg -sf $(cat $PIDFILE)
}
trap reload SIGHUP

rsyslogd
haproxy -p $PIDFILE -f /usr/local/etc/haproxy/haproxy.cfg

while true
do
  sleep infinity & # blocks forever but still make sure bash
  wait || :        # executes reload trap. See:
done               # http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_12_02.html#sect_12_02_02
