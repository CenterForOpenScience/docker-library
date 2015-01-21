FROM haproxy:latest

VOLUME ["/log"]

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r haproxy && useradd -r -g haproxy haproxy -d /home/haproxy -m
RUN chown haproxy /log
