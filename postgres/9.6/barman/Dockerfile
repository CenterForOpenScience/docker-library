FROM postgres:9.6

RUN apt-get update \
    && apt-get install -y \
        barman \
        cron \
        rsyslog \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

COPY barman.conf /etc/barman.conf
COPY crontab /var/spool/cron/crontabs/barman

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

VOLUME /var/lib/barman

CMD ["/bin/bash", "-c", "rsyslogd && chown barman:crontab /var/spool/cron/crontabs/barman && chmod 0600 /var/spool/cron/crontabs/barman && cron && tail -n 0 -f /var/log/syslog /var/log/barman/barman.log"]
