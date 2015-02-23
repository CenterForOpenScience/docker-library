FROM ruby:latest

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r fluentd && useradd -r -g fluentd fluentd

# grab gosu for easy step-down from root
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture)" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture).asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu

ENV FLUENTD_VERSION 0.12.5

RUN apt-get update && \
    && apt-get install -y --no-install-recommends \
        libcurl4-openssl-dev \
        libjemalloc-dev \
    && rm -rf /var/lib/apt/lists/*

RUN echo "gem: --no-document --no-ri --no-rdoc\n" >> ~/.gemrc

RUN gem install \
        fluentd:$FLUENTD_VERSION \
    && fluent-gem install \
        fluent-plugin-elasticsearch \
        fluent-plugin-record-reformer

ENV LD_PRELOAD /usr/lib/x86_64-linux-gnu/libjemalloc.so

ADD fluent.conf /etc/fluent/fluent.conf

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["fluentd", "-c", "/etc/fluent/fluent.conf"]
