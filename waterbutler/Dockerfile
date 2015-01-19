FROM centerforopenscience/python:latest

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

ENV SOURCE_BRANCH develop
ENV SOURCE_REPO https://github.com/CenterForOpenScience/waterbutler.git

RUN git clone -b $SOURCE_BRANCH $SOURCE_REPO .
RUN pip install -r requirements.txt

VOLUME ["/data/osfstorage/pending", "/data/osfstorage/complete"]

EXPOSE 7777

# Replace the entrypoint script with our tornado specific script.
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

CMD ["/bin/bash"]
