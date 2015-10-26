FROM postgres:9.4

# Install dependancies
RUN apt-get update \
    && apt-get install -y \
        # cron (temporary for pre celery-beat jobs)
        cron \
        rsyslog \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

RUN rm -rf /etc/cron.daily/* /etc/cron.hourly/* /etc/cron.monthly/* /etc/cron.weekly/*

ENV CRON_TASK "0 1 * * * bash vacuumlo -h db_host -p db_port -U db_user db_name"

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["/bin/bash", "-c", "touch /var/log/cron.log && rsyslogd && cron && tail -f /var/log/syslog /var/log/cron.log"]
