FROM centerforopenscience/python:2.7

# Install dependancies
RUN apt-get update \
  && apt-get install -y \
    git \
    libev4 \
    libev-dev \
    libevent-dev \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
  && rm -rf /var/lib/apt/lists/*

RUN pip install lxml==3.4.0
RUN pip install uwsgi==2.0.10

EXPOSE 9980
EXPOSE 9443

VOLUME ["/log"]

CMD ["/usr/local/bin/uwsgi", "--ini", "/etc/uwsgi/uwsgi.ini"]
