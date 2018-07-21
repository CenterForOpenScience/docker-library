FROM debian:stretch-slim

# Based On: https://github.com/mikenowak/docker-nessus/blob/master/Dockerfile

RUN apt-get update \
    && apt-get install -y \
        curl \
        gpg \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

COPY Nessus-7.1.2-debian6_amd64.deb /tmp/nessus.deb

RUN curl -o /tmp/RPM-GPG-Key-Tenable -SL "https://static.tenable.com/marketing/RPM-GPG-KEY-Tenable" \
    && gpg --import /tmp/RPM-GPG-Key-Tenable \
    && dpkg -i /tmp/nessus.deb \
    && rm /tmp/nessus.deb \
    && rm /tmp/RPM-GPG-Key-Tenable

VOLUME ["/opt/nessus"]

EXPOSE 8834

CMD ["/opt/nessus/sbin/nessus-service"]
