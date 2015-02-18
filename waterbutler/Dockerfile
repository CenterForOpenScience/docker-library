FROM centerforopenscience/python:3.4-slim

VOLUME ["/data/osfstorage/pending", "/data/osfstorage/complete"]
VOLUME ["/log"]

# Install dependancies
RUN apt-get update \
  && apt-get install -y \
    git \
    par2 \
    libevent-dev \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
  && rm -rf /var/lib/apt/lists/*

EXPOSE 7777

# Replace the entrypoint script with our tornado specific script.
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

CMD ["/bin/bash"]
