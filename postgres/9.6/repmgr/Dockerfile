FROM postgres:9.6

RUN apt-get update \
    && apt-get install -y \
        supervisor \
        postgresql-9.6-repmgr \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord"]
