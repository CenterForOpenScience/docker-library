FROM postgres:9.6

RUN apt-get update \
    && apt-get install -y \
        barman=2.1-1.pgdg80+1 \
        cron \
        rsyslog \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

COPY barman.conf /etc/barman.conf
COPY crontab /var/spool/cron/crontabs/barman

CMD ["/bin/bash", "-c", "rsyslogd && chown barman:crontab /var/spool/cron/crontabs/barman && chmod 0600 /var/spool/cron/crontabs/barman && cron && tail -n 0 -f /var/log/syslog"]
