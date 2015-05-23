FROM postgres:9.4

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

VOLUME ["/log"]

CMD ["/bin/bash", "-c", "/docker-entrypoint.sh postgres 1> >(tee -a /log/output.log) 2> >(tee -a /log/error.log)"]
