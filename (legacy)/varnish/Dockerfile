FROM debian:jessie

ENV VARNISH_VERSION 4.1
RUN apt-get update \
    && apt-get install -y \
        curl \
        automake \
        git \
        libtool \
        make \
        python-docutils \
    && curl "http://repo.varnish-cache.org/GPG-key.txt" | apt-key add -- \
    && echo "deb http://repo.varnish-cache.org/debian/ jessie varnish-$VARNISH_VERSION" >> /etc/apt/sources.list.d/varnish-cache.list \
    && apt-get update \
    && apt-get install -y \
        varnish \
        libvarnishapi-dev \
    && apt-get clean \
    && apt-get autoremove -y \
        curl \
    && rm -rf /var/lib/apt/lists/*

RUN cd /tmp \
    && git clone https://github.com/varnish/libvmod-rtstatus.git \
    && cd libvmod-rtstatus \
    && git checkout $VARNISH_VERSION \
    && ./autogen.sh \
    && ./configure VARNISHSRC=/usr/include/varnish \
    && make \
    && make install

VOLUME '/var/lib/varnish'

CMD ['varnishd', '-F', '-f', '/etc/varnish/default.vcl']
