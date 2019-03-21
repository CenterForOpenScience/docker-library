#!/bin/sh

touch /id_rsa
chmod 0400 /id_rsa

# Pick a random port above 32768
DEFAULT_PORT=$RANDOM
let "DEFAULT_PORT += 32768"
echo [INFO] Tunneling ${SSH_HOSTUSER:=root}@${SSH_HOSTNAME:=localhost}:${SSH_TUNNEL_BIND_PORT:=${DEFAULT_PORT}} to ${SSH_TUNNEL_HOST=localhost}:${SSH_TUNNEL_HOST_PORT:=22}

echo autossh \
 -M 0 \
 -o StrictHostKeyChecking=no \
 -o ServerAliveInterval=5 \
 -o ServerAliveCountMax=1 \
 -N \
 -i ${IDENTITY_FILE:="/id_rsa"} \
 -L 0.0.0.0:${SSH_TUNNEL_BIND_PORT}:${SSH_TUNNEL_HOST}:${SSH_TUNNEL_HOST_PORT} \
 -p ${SSH_HOSTPORT:=22} \
 ${SSH_HOSTUSER}@${SSH_HOSTNAME}

AUTOSSH_PIDFILE=/autossh.pid \
AUTOSSH_POLL=10 \
AUTOSSH_LOGLEVEL=0 \
AUTOSSH_LOGFILE=/dev/stdout \
autossh \
 -M 0 \
 -o StrictHostKeyChecking=no \
 -o ServerAliveInterval=5 \
 -o ServerAliveCountMax=1 \
 -N \
 -i ${IDENTITY_FILE} \
 -L 0.0.0.0:${SSH_TUNNEL_BIND_PORT}:${SSH_TUNNEL_HOST}:${SSH_TUNNEL_HOST_PORT} \
 -p ${SSH_HOSTPORT:=22} \
 ${SSH_HOSTUSER}@${SSH_HOSTNAME}
