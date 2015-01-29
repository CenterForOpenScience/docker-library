FROM debian:wheezy

EXPOSE 514/tcp
EXPOSE 514/udp

# Install dependancies
RUN apt-get update \
  && apt-get install -y \
    rsyslog \
  && rm -rf /var/lib/apt/lists/*

RUN sed 's/#$ModLoad imudp/$ModLoad imudp/' -i /etc/rsyslog.conf
RUN sed 's/#$UDPServerRun 514/$UDPServerRun 514/' -i /etc/rsyslog.conf
RUN sed 's/#$ModLoad imtcp/$ModLoad imtcp/' -i /etc/rsyslog.conf
RUN sed 's/#$InputTCPServerRun 514/$InputTCPServerRun 514/' -i /etc/rsyslog.conf

ENTRYPOINT ["/usr/sbin/rsyslogd", "-n"]
