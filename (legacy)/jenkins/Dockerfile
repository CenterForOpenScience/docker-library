FROM jenkins:1.625.1

USER root

RUN apt-get update \
    # jenkins dependencies
    && apt-get install -y \
        git \
        curl \
        python-pip \
        # docker (mount)
        apparmor \
        libsystemd-journal0 \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# grab gosu for easy step-down from root
ENV GOSU_VERSION 1.4
RUN apt-get update \
    && gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
  	&& curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
  	&& gpg --verify /usr/local/bin/gosu.asc \
  	&& rm /usr/local/bin/gosu.asc \
  	&& chmod +x /usr/local/bin/gosu

# kubernetes
ENV KUBERNETES_VERSION 1.3.3
ENV KUBERNETES_SHA256 7ecb4ce0af38d847cdc4976f72530c73b4533a8b973489b92508363566dcfd61
RUN curl -o /usr/local/bin/kubectl -SL "https://storage.googleapis.com/kubernetes-release/release/v$KUBERNETES_VERSION/bin/linux/amd64/kubectl" \
    && echo "$KUBERNETES_SHA256  /usr/local/bin/kubectl" | sha256sum -c - \
    && chmod +x /usr/local/bin/kubectl

RUN pip install invoke

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["/bin/tini", "--", "/usr/local/bin/jenkins.sh"]
