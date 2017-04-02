FROM postgres:9.6

RUN apt-get update \
    && apt-get install -y \
        supervisor \
        postgresql-9.6-repmgr \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

COPY repmgr.conf /etc/repmgr/repmgr.conf
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

VOLUME /var/lib/barman

CMD ["/usr/bin/supervisord"]
