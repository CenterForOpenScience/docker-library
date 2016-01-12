FROM postgres:9.4

RUN apt-get update \
    && apt-get install -y \
        supervisor \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# repmgr
ENV REPMGR_VERSION 3.0.2
RUN apt-get update \
    && apt-get install -y \
        curl \
        make \
        gcc \
        # dependencies
        libxslt-dev \
        libxml2-dev \
        libpam-dev \
        libedit-dev \
        postgresql-server-dev-9.4 \
        libselinux-dev \
    # download and verify
    && cd /tmp \
    && curl -O -SL "http://repmgr.org/download/repmgr-$REPMGR_VERSION.tar.gz" \
    && curl -O -SL "http://repmgr.org/download/repmgr-$REPMGR_VERSION.tar.gz.asc" \
    && gpg --keyserver pool.sks-keyservers.net --recv-keys 297F1DCC \
    && gpg --verify /tmp/repmgr-$REPMGR_VERSION.tar.gz.asc \
    && rm /tmp/repmgr-$REPMGR_VERSION.tar.gz.asc \
    # make and install
    && tar xvf /tmp/repmgr-$REPMGR_VERSION.tar.gz \
    && cd /tmp/repmgr-$REPMGR_VERSION \
    && make USE_PGXS=1 install \
    # configuration
    && mkdir -p /etc/repmgr \
    && cp /tmp/repmgr-$REPMGR_VERSION/repmgr.conf.sample /etc/repmgr/ \
    # cleanup
    && rm -Rf /tmp/repmgr-$REPMGR_VERSION* \
    && apt-get clean \
    && apt-get autoremove -y \
        curl \
        make \
        gcc \
    && rm -rf /var/lib/apt/lists/*

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord"]
