FROM centerforopenscience/python:2.7

# Install dependancies
RUN apt-get update \
  && apt-get install -y \
    git \
    npm \
    libev4 \
    libev-dev \
    libevent-dev \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
  && rm -rf /var/lib/apt/lists/*

RUN pip install lxml==3.4.2
RUN pip install uwsgi==2.0.10
RUN npm install -g bower

EXPOSE 9980
EXPOSE 9443

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

VOLUME ["/log"]

CMD ["/usr/local/bin/uwsgi", "--ini", "/etc/uwsgi/uwsgi.ini"]
