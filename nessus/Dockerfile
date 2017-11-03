FROM debian:stretch-slim

# Based On: https://github.com/mikenowak/docker-nessus/blob/master/Dockerfile

RUN apt-get update \
    && apt-get install -y \
        curl \
        gpg \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

ENV NESSUS_VERSION 6.11.2
RUN set -x \
    && FILE_NAME=Nessus-${NESSUS_VERSION}-debian6_$(dpkg --print-architecture).deb \
    && TOKEN=$(curl -ssl -o - "https://www.tenable.com/products/nessus/select-your-operating-system" | sed -n -e 's/.*id="timecheck" class="hidden">\(.*\)<\/div>.*/\1/p') \
    && curl -o /tmp/${FILE_NAME} -SL "http://downloads.nessus.org/nessus3dl.php?file=${FILE_NAME}&licence_accept=yes&t=${TOKEN}" \
    && curl -o /tmp/RPM-GPG-Key-Tenable -SL "https://static.tenable.com/marketing/RPM-GPG-KEY-Tenable" \
    && gpg --import /tmp/RPM-GPG-Key-Tenable \
    && dpkg -i /tmp/${FILE_NAME} \
    && rm /tmp/${FILE_NAME} \
    && rm /tmp/RPM-GPG-Key-Tenable

VOLUME ["/opt/nessus"]

EXPOSE 8834

CMD ["/opt/nessus/sbin/nessus-service"]
