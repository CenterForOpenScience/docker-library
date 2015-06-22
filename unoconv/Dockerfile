FROM python:3.4-slim

RUN apt-get update \
    && apt-get install -y \
        git \
        imagemagick \
        libreoffice-script-provider-python \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# additional fonts
RUN apt-get update \
    && echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections \
    && apt-get install -y \
        fonts-arphic-ukai \
        fonts-arphic-uming \
        fonts-ipafont-mincho \
        fonts-ipafont-gothic \
        fonts-unfonts-core \
        ttf-wqy-zenhei \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# grab gosu for easy step-down from root
ENV GOSU_VERSION 1.4
RUN apt-get update \
    && apt-get install -y \
        curl \
    && gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
  	&& curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
  	&& gpg --verify /usr/local/bin/gosu.asc \
  	&& rm /usr/local/bin/gosu.asc \
  	&& chmod +x /usr/local/bin/gosu \
    && apt-get clean \
    && apt-get autoremove -y \
        curl \
    && rm -rf /var/lib/apt/lists/*

RUN usermod -d /home www-data \
    && chown www-data:www-data /home

ENV LIBREOFFICE_VERSION 4.4.3
ENV LIBREOFFICE_ARCHIVE LibreOffice_4.4.3_Linux_x86-64_deb.tar.gz

RUN apt-get update \
    && apt-get install -y \
        curl \
    && curl -SL "http://download.documentfoundation.org/libreoffice/stable/$LIBREOFFICE_VERSION/deb/x86_64/$LIBREOFFICE_ARCHIVE" -o $LIBREOFFICE_ARCHIVE \
    && curl -SL "http://download.documentfoundation.org/libreoffice/stable/$LIBREOFFICE_VERSION/deb/x86_64/$LIBREOFFICE_ARCHIVE.sha256" -o $LIBREOFFICE_ARCHIVE.sha256 \
    && sha256sum --check "$LIBREOFFICE_ARCHIVE.sha256" \
    && mkdir /tmp/libreoffice \
    && tar -xvf "$LIBREOFFICE_ARCHIVE" -C /tmp/libreoffice/ --strip-components=1 \
    && dpkg -i /tmp/libreoffice/**/*.deb \
    && rm $LIBREOFFICE_ARCHIVE* \
    && rm -Rf /tmp/libreoffice \
    && apt-get clean \
    && apt-get autoremove -y \
        curl \
    && rm -rf /var/lib/apt/lists/*

# install the latest unoconv script as their last tag is 2 years out of date
ADD https://raw.githubusercontent.com/dagwieers/unoconv/master/unoconv /usr/bin/unoconv
RUN chmod +xr /usr/bin/unoconv

ENV UNO_PATH=/opt/libreoffice4.4

# first run will fail, however it will setup the environment for the next run to be successful
USER www-data
RUN /usr/bin/unoconv --listener --server=0.0.0.0 --port=2002 -vvv
USER root

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

WORKDIR /unoconv
VOLUME ["/unoconv", "/log"]
EXPOSE 2002

CMD ["/usr/bin/unoconv", "--listener", "--server=0.0.0.0", "--port=2002", "-vvv"]
