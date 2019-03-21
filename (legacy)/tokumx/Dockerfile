FROM debian:wheezy

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r tokumx && useradd -r -g tokumx tokumx

RUN apt-get update \
    && apt-get install -y \
        numactl \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# grab gosu for easy step-down from root
ENV GOSU_VERSION 1.4
RUN apt-get update \
    && apt-get install -y \
        curl \
    && gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
  	&& curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
  	&& gpg --verify /usr/local/bin/gosu.asc \
  	&& rm /usr/local/bin/gosu.asc \
  	&& chmod +x /usr/local/bin/gosu \
    && apt-get clean \
    && apt-get autoremove -y \
        curl \
    && rm -rf /var/lib/apt/lists/*

ENV TOKUMX_VERSION 2.0.1-1
RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 505A7412 \
    && echo "deb [arch=amd64] http://s3.amazonaws.com/tokumx-debs wheezy main" > /etc/apt/sources.list.d/tokumx.list \
    && apt-get update \
    && apt-get install -y \
        tokumx=$TOKUMX_VERSION \
    && rm -rf /var/lib/tokumx \
  	&& mv /etc/tokumx.conf /etc/tokumx.conf.orig \
    && mkdir -p /data/db \
    && chown -R tokumx:tokumx /data/db \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

VOLUME /data/db

EXPOSE 27017
EXPOSE 28017

# NOTE: While testing the docker container you can override toku's hard requirement
# for transparent huge page sharing by setting the following environment variable.
#
# TOKU_HUGE_PAGES_OK=1
#
# Production systems see the following guide detailing how to disable this setting at boot.
# http://docs.mongodb.org/manual/tutorial/transparent-huge-pages/#in-etc-rc-local-alternate

CMD ["mongod"]
