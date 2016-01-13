FROM haproxy:1.6

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r haproxy && useradd -r -g haproxy haproxy

# Install dependancies
RUN apt-get update \
    && apt-get install -y \
        rsyslog \
        socat \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

ADD rsyslog.conf /etc/rsyslog.conf

COPY command.sh /command.sh
RUN chmod +x /command.sh
CMD ["/command.sh"]
