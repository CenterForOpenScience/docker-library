#!/bin/bash
set -e

cp /home/.cos/access.conf /etc/fwknop/access.conf
cp /home/.cos/fwknopd.conf /etc/fwknop/fwknopd.conf
chown root:root /etc/fwknop/access.conf
chown root:root /etc/fwknop/fwknopd.conf
chmod -R 600 /etc/fwknop
ls -lah /etc/fwknop/
#/usr/sbin/fwknopd

exec "$@"