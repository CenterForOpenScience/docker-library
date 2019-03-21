FROM ruby:2.0

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

ENV FLUENTD_VERSION 0.12.12
# ENV FLUENTD_GEMS "fluent-plugin-..."
RUN apt-get update \
    && apt-get install -y \
        libcurl4-openssl-dev \
        libjemalloc-dev \
    && echo "gem: --no-document --no-ri --no-rdoc\n" >> ~/.gemrc \
    && gem install fluentd:$FLUENTD_VERSION \
    && fluentd --setup /etc/fluent \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# Use approved plugins
RUN gem install specific_install \
    && gem specific_install https://github.com/CenterForOpenScience/fluent-plugin-logentries.git master \
    && gem specific_install https://github.com/CenterForOpenScience/fluent-plugin-docker-format.git master \
    && fluent-gem install fluent-plugin-rewrite-tag-filter -v 1.5.5

ENV LD_PRELOAD /usr/lib/x86_64-linux-gnu/libjemalloc.so

VOLUME /etc/fluent

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["fluentd", "-c", "/etc/fluent/fluent.conf"]
