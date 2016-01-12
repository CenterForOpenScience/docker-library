FROM debian:jessie

ENV VARNISH_VERSION 4.1
RUN apt-get update \
    && apt-get install -y \
        curl \
    && curl "http://repo.varnish-cache.org/GPG-key.txt" | apt-key add -- \
    && echo "deb http://repo.varnish-cache.org/debian/ jessie varnish-$VARNISH_VERSION" >> /etc/apt/sources.list.d/varnish-cache.list \
    && apt-get update \
    && apt-get install -y varnish --no-install-recommends \
    && apt-get clean \
    && apt-get autoremove -y \
        curl \
    && rm -rf /var/lib/apt/lists/*

VOLUME '/var/lib/varnish'

CMD ['varnishd', '-F', '-f', '/etc/varnish/default.vcl']
