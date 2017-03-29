FROM postgres:9.6

RUN apt-get update \
    && apt-get install -y \
        supervisor \
        openssh-server \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /var/run/sshd
EXPOSE 22

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord"]
