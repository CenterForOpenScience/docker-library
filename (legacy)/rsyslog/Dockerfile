FROM debian:wheezy

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r rsyslog && useradd -r -g rsyslog rsyslog

# Install dependancies
RUN apt-get update \
  && apt-get install -y \
    rsyslog \
  && rm -rf /var/lib/apt/lists/*

# Allow tcp/udp port 514
RUN sed 's/#$ModLoad imudp/$ModLoad imudp/' -i /etc/rsyslog.conf
RUN sed 's/#$UDPServerRun 514/$UDPServerRun 514/' -i /etc/rsyslog.conf
RUN sed 's/#$ModLoad imtcp/$ModLoad imtcp/' -i /etc/rsyslog.conf
RUN sed 's/#$InputTCPServerRun 514/$InputTCPServerRun 514/' -i /etc/rsyslog.conf

# Set the default permissions for all log files.
RUN sed 's/$FileOwner root/$FileOwner rsyslog/' -i /etc/rsyslog.conf
RUN sed 's/$Umask 0022/$Umask 0022\n$PrivDropToUser rsyslog\n$PrivDropToGroup rsyslog/' -i /etc/rsyslog.conf

EXPOSE 514
EXPOSE 514/udp

CMD ["/usr/sbin/rsyslogd", "-n"]
