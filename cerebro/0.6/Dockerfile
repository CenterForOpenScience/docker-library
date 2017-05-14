FROM openjdk:8-jre

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r cerebro && useradd -r -g cerebro cerebro

# grab gosu for easy step-down from root
ENV GOSU_VERSION 1.7
RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
    && gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
	&& gosu nobody true

ENV CEREBRO_VERSION 0.6.5
ENV CEREBRO_SHA256 e0fab203496c3216561070df0b2dbd90ade83dfa0dc2fb380a88369958dc1e28
RUN cd /tmp \
    && curl -o cerebro-${CEREBRO_VERSION}.tgz -SL "https://github.com/lmenezes/cerebro/releases/download/v${CEREBRO_VERSION}/cerebro-${CEREBRO_VERSION}.tgz" \
    && echo "$CEREBRO_SHA256  /tmp/cerebro-${CEREBRO_VERSION}.tgz" | sha256sum -c - \
    && tar zxvf /tmp/cerebro-${CEREBRO_VERSION}.tgz \
    && mkdir /tmp/cerebro-${CEREBRO_VERSION}/logs \
    && mv /tmp/cerebro-${CEREBRO_VERSION} /opt/cerebro \
    && rm /tmp/cerebro-${CEREBRO_VERSION}.tgz

WORKDIR /opt/cerebro

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 9000

VOLUME ["/opt/cerebro/conf", "/opt/cerebro/logs"]

CMD ["bin/cerebro"]
