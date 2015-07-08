FROM debian:wheezy

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r tokumx && useradd -r -g tokumx tokumx

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

ENV TOKUMX_VERSION 2.0.1
ENV TOKUMX_ARCHIVE tokumx-$TOKUMX_VERSION-linux-x86_64-main.tar.gz
RUN curl -SL "https://s3.amazonaws.com/tokumx-$TOKUMX_VERSION/$TOKUMX_ARCHIVE" -o $TOKUMX_ARCHIVE \
    && curl -SL "https://s3.amazonaws.com/tokumx-$TOKUMX_VERSION/$TOKUMX_ARCHIVE.md5" -o $TOKUMX_ARCHIVE.md5 \
    && md5sum --check "$TOKUMX_ARCHIVE.md5" \
    && tar -xvf "$TOKUMX_ARCHIVE" -C /usr/local --strip-components=1 \
    && rm $TOKUMX_ARCHIVE*

# NOTE: While testing the docker container you can override toku's hard requirement
# to disabled transparent huge page sharing by setting the following environment variable.
#
# TOKU_HUGE_PAGES_OK=1
#
# Production systems see the following guide detailing how to disable this setting at boot.
# http://docs.mongodb.org/manual/tutorial/transparent-huge-pages/#in-etc-rc-local-alternate

ADD tokumx.conf /etc/tokumx.conf

VOLUME /data
VOLUME /log

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 27017
EXPOSE 28017

CMD ["/bin/bash", "-c", "mongod --config /etc/tokumx.conf 2>&1 1> >(tee -a /log/tokumx.log)"]
