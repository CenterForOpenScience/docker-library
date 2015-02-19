FROM centerforopenscience/python:2.7-slim

VOLUME ["/log"]

# Install dependancies
RUN apt-get update \
  && apt-get install -y \
    git \
    libevent-dev \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
  && rm -rf /var/lib/apt/lists/*

EXPOSE 80
EXPOSE 443

# Replace the entrypoint script with our application specific script.
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

CMD ["/bin/bash"]
