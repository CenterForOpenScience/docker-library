FROM postgres:9.6

# Install dependancies
RUN apt-get update \
    && apt-get install -y \
        cron \
        rsyslog \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

ENV SCHEDULE "0 2 * * *"
# ENV DB_HOST "127.0.0.1"
# ENV DB_PORT "5432"
# ENV DB_USER "repmgr"
# ENV DB_PASSWORD "change_me"
ENV DB_NAME "postgres"

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["/bin/bash", "-c", "rsyslogd && cron && tail -n 0 -f /var/log/syslog"]
