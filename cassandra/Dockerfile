FROM java:7-jdk

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r cassandra && useradd -r -g cassandra cassandra

RUN apt-get update \
    && apt-get install -y curl \
    && rm -rf /var/lib/apt/lists/*

# grab gosu for easy step-down from root
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture)" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture).asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu

ENV CASSANDRA_RELEASE_FINGERPRINT 0353B12C
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys $CASSANDRA_RELEASE_FINGERPRINT

ENV CASSANDRA_VERSION 2.1.6
ENV CASSANDRA_CONFIG /opt/cassandra/conf

RUN curl -SL "https://www.apache.org/dist/cassandra/$CASSANDRA_VERSION/apache-cassandra-$CASSANDRA_VERSION-bin.tar.gz" -o cassandra.tgz \
    && curl -SL "https://www.apache.org/dist/cassandra/$CASSANDRA_VERSION/apache-cassandra-$CASSANDRA_VERSION-bin.tar.gz.asc" -o cassandra.tgz.asc \
    && gpg --verify cassandra.tgz.asc \
    && mkdir -p /opt/cassandra \
    && tar -xvf cassandra.tgz -C /opt/cassandra --strip-components=1 \
    && rm cassandra.tgz*

RUN chown -R cassandra /opt/cassandra

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 7199 7000 7001 9160 9042

VOLUME ["/opt/cassandra/data", "/opt/cassandra/logs"]

CMD ["/opt/cassandra/bin/cassandra", "-f"]
