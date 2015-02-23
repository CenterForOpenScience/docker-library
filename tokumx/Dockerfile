FROM debian:wheezy

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r tokumx && useradd -r -g tokumx tokumx

RUN apt-get update \
    && apt-get install -y curl \
    && rm -rf /var/lib/apt/lists/*

# grab gosu for easy step-down from root
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture)" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture).asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu

ENV TOKUMX_VERSION 2.0.0
ENV TOKUMX_ARCHIVE tokumx-$TOKUMX_VERSION-linux-x86_64-main.tar.gz

RUN curl -SL "https://s3.amazonaws.com/tokumx-2.0.0/$TOKUMX_ARCHIVE" -o $TOKUMX_ARCHIVE \
    && curl -SL "https://s3.amazonaws.com/tokumx-2.0.0/$TOKUMX_ARCHIVE.md5" -o $TOKUMX_ARCHIVE.md5 \
    && md5sum --check "$TOKUMX_ARCHIVE.md5" \
    && tar -xvf "$TOKUMX_ARCHIVE" -C /usr/local --strip-components=1 \
    && rm $TOKUMX_ARCHIVE*

VOLUME /data/db

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 27017

CMD ["mongod"]
