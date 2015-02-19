#!/bin/bash
set -e

# Get running container's IP
IP=`hostname --ip-address`
if [ $# == 1 ]; then SEEDS="$1,$IP"; 
else SEEDS="$IP"; fi

# configuration
sed -i -e "s/num_tokens/\#num_tokens/" $CASSANDRA_CONFIG/cassandra.yaml
sed -i -e "s/- seeds: \"127.0.0.1\"/- seeds: \"$SEEDS\"/" $CASSANDRA_CONFIG/cassandra.yaml
sed -i -e "s/^rpc_address.*/rpc_address: 0.0.0.0/" $CASSANDRA_CONFIG/cassandra.yaml
sed -i -e "s/^listen_address.*/listen_address: $IP/" $CASSANDRA_CONFIG/cassandra.yaml
sed -i -e "s/^\# broadcast_rpc_address.*/broadcast_rpc_address: $IP/" $CASSANDRA_CONFIG/cassandra.yaml

# environment
sed -i -e "s/# JVM_OPTS=\"$JVM_OPTS -Djava.rmi.server.hostname.*\"/ JVM_OPTS=\"$JVM_OPTS -Djava.rmi.server.hostname=$IP\"/" $CASSANDRA_CONFIG/cassandra-env.sh
echo "JVM_OPTS=\"\$JVM_OPTS -Dcassandra.initial_token=0\"" >> $CASSANDRA_CONFIG/cassandra-env.sh
echo "JVM_OPTS=\"\$JVM_OPTS -Dcassandra.skip_wait_for_gossip_to_settle=0\"" >> $CASSANDRA_CONFIG/cassandra-env.sh

if [ ! -z "$CASSANDRA_DC" ]; then
    sed -i -e "s/endpoint_snitch: SimpleSnitch/endpoint_snitch: PropertyFileSnitch/" $CASSANDRA_CONFIG/cassandra.yaml
    echo "default=$CASSANDRA_DC:rac1" > $CASSANDRA_CONFIG/cassandra-topology.properties
fi

if [[ $(stat -c '%U' /opt/cassandra/data/commitlog) != cassandra ]]; then
    chown -R cassandra /opt/cassandra/data/commitlog
fi

if [[ $(stat -c '%U' /opt/cassandra/data/data) != cassandra ]]; then
    chown -R cassandra /opt/cassandra/data/data
fi

if [[ $(stat -c '%U' /opt/cassandra/data/saved_caches) != cassandra ]]; then
    chown -R cassandra /opt/cassandra/data/saved_caches
fi

if [[ $(stat -c '%U' /opt/cassandra/logs) != cassandra ]]; then
    chown -R cassandra /opt/cassandra/logs
fi

exec gosu cassandra "$@"
