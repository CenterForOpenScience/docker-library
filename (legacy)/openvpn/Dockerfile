# Original credit: https://github.com/jpetazzo/dockvpn, https://github.com/kylemanna/docker-openvpn

FROM debian:jessie

# Install dependancies
RUN apt-get update \
    && apt-get install -y \
        iptables \
        openvpn \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

ENV EASYRSA_VERSION 3.0.0
RUN apt-get update \
    && apt-get install -y \
        curl \
    && gpg --keyserver pool.sks-keyservers.net --recv-keys 390D0D0E \
    && curl -SLO "https://github.com/OpenVPN/easy-rsa/releases/download/$EASYRSA_VERSION/EasyRSA-$EASYRSA_VERSION.tgz" \
    && curl -SLO "https://github.com/OpenVPN/easy-rsa/releases/download/$EASYRSA_VERSION/EasyRSA-$EASYRSA_VERSION.tgz.sig" \
    && gpg --verify "EasyRSA-$EASYRSA_VERSION.tgz.sig" \
    && mkdir -p /usr/local/share/easy-rsa \
    && tar -xzf "EasyRSA-$EASYRSA_VERSION.tgz" -C /usr/local/share/easy-rsa --strip-components=1 \
    && ln -s /usr/local/share/easy-rsa/easyrsa /usr/local/bin \
    && rm "EasyRSA-$EASYRSA_VERSION.tgz" "EasyRSA-$EASYRSA_VERSION.tgz.sig" \
    && apt-get clean \
    && apt-get autoremove -y \
        curl \
    && rm -rf /var/lib/apt/lists/*

# Needed by scripts
ENV OPENVPN /etc/openvpn
ENV EASYRSA /usr/local/share/easy-rsa
ENV EASYRSA_PKI $OPENVPN/pki
ENV EASYRSA_VARS_FILE $OPENVPN/vars

VOLUME "/etc/openvpn"

EXPOSE 1194/udp

WORKDIR /etc/openvpn
CMD "ovpn_run"

ADD ./bin /usr/local/bin
RUN chmod a+x /usr/local/bin/*
