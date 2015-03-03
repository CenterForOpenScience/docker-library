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

EXPOSE 80
EXPOSE 443

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

VOLUME ["/log"]

CMD ["/bin/bash"]
