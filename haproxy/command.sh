#!/bin/bash
# Credit: https://github.com/discordianfish/haproxy-docker/
set -e

reload() {
  echo "Reloading config"
  haproxy -p /tmp/haproxy.pid -f /usr/local/etc/haproxy/haproxy.cfg -sf $(cat /tmp/haproxy.pid)
}
trap reload SIGHUP

rm -f /tmp/rsyslogd.pid
rsyslogd -i /tmp/rsyslogd.pid

rm -f /tmp/haproxy.pid
haproxy -p /tmp/haproxy.pid -f /usr/local/etc/haproxy/haproxy.cfg

while true
do
  sleep infinity & # blocks forever but still make sure bash
  wait || :        # executes reload trap. See:
done               # http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_12_02.html#sect_12_02_02
