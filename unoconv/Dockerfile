FROM python:3.6-slim-stretch

RUN apt-get update \
    && apt-get install -y \
        git \
        imagemagick \
        libreoffice-script-provider-python \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# additional fonts
RUN echo "deb http://httpredir.debian.org/debian stretch main contrib non-free" > /etc/apt/sources.list \
    && echo "deb http://httpredir.debian.org/debian stretch-updates main contrib non-free" >> /etc/apt/sources.list \
    && echo "deb http://security.debian.org/ stretch/updates main contrib non-free" >> /etc/apt/sources.list \
    && echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections \
    && apt-get update \
    && apt-get install -y \
        fonts-arphic-ukai \
        fonts-arphic-uming \
        fonts-ipafont-mincho \
        fonts-ipafont-gothic \
        fonts-unfonts-core \
        ttf-wqy-zenhei \
        ttf-mscorefonts-installer \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# grab gosu for easy step-down from root
ENV GOSU_VERSION 1.4
RUN apt-get update \
    && apt-get install -y \
        curl \
        gnupg2 \
    && mkdir ~/.gnupg && chmod 600 ~/.gnupg && echo "disable-ipv6" >> ~/.gnupg/dirmngr.conf \
    && for server in hkp://ipv4.pool.sks-keyservers.net:80 \
                     hkp://ha.pool.sks-keyservers.net:80 \
                     hkp://pgp.mit.edu:80 \
                     hkp://keyserver.pgp.com:80 \
    ; do \
      gpg --keyserver "$server" --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 && break || echo "Trying new server..." \
    ; done \
    && curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
  	&& curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
  	&& gpg --verify /usr/local/bin/gosu.asc \
  	&& rm /usr/local/bin/gosu.asc \
  	&& chmod +x /usr/local/bin/gosu \
    && apt-get clean \
    && apt-get autoremove -y \
        curl \
        gnupg2 \
    && rm -rf /var/lib/apt/lists/*

RUN usermod -d /home www-data \
    && chown www-data:www-data /home

ENV LIBREOFFICE_VERSION 6.1.5
ENV LIBREOFFICE_ARCHIVE LibreOffice_6.1.5_Linux_x86-64_deb.tar.gz
ENV LIBREOFFICE_MIRROR_URL https://download.documentfoundation.org/libreoffice/stable/
RUN apt-get update \
    && apt-get install -y \
        curl \
        gnupg2 \
    && for server in hkp://ipv4.pool.sks-keyservers.net:80 \
                     hkp://ha.pool.sks-keyservers.net:80 \
                     hkp://pgp.mit.edu:80 \
                     hkp://keyserver.pgp.com:80 \
    ; do \
      gpg --keyserver "$server" --recv-keys AFEEAEA3 && break || echo "Trying new server..." \
    ; done \
    && curl -SL "$LIBREOFFICE_MIRROR_URL/$LIBREOFFICE_VERSION/deb/x86_64/$LIBREOFFICE_ARCHIVE" -o $LIBREOFFICE_ARCHIVE \
        && curl -SL "$LIBREOFFICE_MIRROR_URL/$LIBREOFFICE_VERSION/deb/x86_64/$LIBREOFFICE_ARCHIVE.asc" -o $LIBREOFFICE_ARCHIVE.asc \
        && gpg --verify "$LIBREOFFICE_ARCHIVE.asc" \
        && mkdir /tmp/libreoffice \
        && tar -xvf "$LIBREOFFICE_ARCHIVE" -C /tmp/libreoffice/ --strip-components=1 \
        && dpkg -i /tmp/libreoffice/**/*.deb \
        && rm $LIBREOFFICE_ARCHIVE* \
        && rm -Rf /tmp/libreoffice \
    && apt-get clean \
    && apt-get autoremove -y \
        curl \
        gnupg2 \
    && rm -rf /var/lib/apt/lists/*

RUN pip install unoconv==0.8.2

ENV UNO_PATH=/opt/libreoffice6.1

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 2002

CMD ["gosu", "www-data", "/opt/libreoffice6.1/program/python", "-u", "/usr/local/bin/unoconv", "--listener", "--server=0.0.0.0", "--port=2002", "-vvv"]
