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

ENV SCHEDULE "0 2 * * *"
# ENV DB_HOST "127.0.0.1"
# ENV DB_PORT "5432"
# ENV DB_USER "repmgr"
# ENV DB_PASSWORD "change_me"
ENV DB_NAME "postgres"

RUN chmod 600 /etc/crontab

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["/bin/bash", "-c", "touch /var/log/cron.log && rsyslogd && cron && tail -f /var/log/syslog /var/log/cron.log"]
