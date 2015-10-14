# Original credit: https://github.com/jpetazzo/dockvpn, https://github.com/kylemanna/docker-openvpn

FROM debian:jessie

# Install dependancies
RUN apt-get update \
    && apt-get install -y \
        easy-rsa \
        iptables \
        openvpn \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# Needed by scripts
ENV OPENVPN /etc/openvpn
ENV EASYRSA /usr/share/easy-rsa
ENV EASYRSA_PKI $OPENVPN/pki
ENV EASYRSA_VARS_FILE $OPENVPN/vars

VOLUME "/etc/openvpn"

EXPOSE 1194/udp

WORKDIR /etc/openvpn
CMD "ovpn_run"

ADD ./bin /usr/local/bin
RUN chmod a+x /usr/local/bin/*
