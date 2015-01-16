FROM haproxy:latest

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r haproxy && useradd -r -g haproxy haproxy -d /home/haproxy -m

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

VOLUME ["/etc/ssl/private"]
