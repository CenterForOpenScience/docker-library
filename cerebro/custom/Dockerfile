### App code
FROM openjdk:8-jdk AS app

ENV SBT_VERSION 1.1.6
RUN curl -L -o sbt-$SBT_VERSION.deb http://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb \
    && dpkg -i sbt-$SBT_VERSION.deb \
    && rm sbt-$SBT_VERSION.deb \
    && apt-get update \
    && apt-get install sbt \
    && sbt sbtVersion

WORKDIR /src

ENV CEREBRO_VERSION 0.7.3
RUN && git clone -b v${CEREBRO_VERSION} https://github.com/lmenezes/cerebro.git . \
    && sbt universal:packageZipTarball \
    && mv /src/target/universal/cerebro-${CEREBRO_VERSION}.tgz /src/target/universal/cerebro.tgz


### Dist
FROM openjdk:8-jre AS dist

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

COPY --from=app /src/target/universal/cerebro.tgz /tmp

RUN mkdir /tmp/cerebro \
    && cd /tmp/cerebro \
    && tar zxvf /tmp/cerebro.tgz --strip 1 \
    && mkdir /tmp/cerebro/logs \
    && mv /tmp/cerebro /opt/cerebro \
    && rm /tmp/cerebro.tgz

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

WORKDIR /opt/cerebro

EXPOSE 9000

VOLUME ["/opt/cerebro/conf", "/opt/cerebro/logs"]

CMD ["bin/cerebro"]


### Dev
FROM app AS dev

EXPOSE 9000

CMD ["sbt", "run"]

