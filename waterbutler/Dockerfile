FROM centerforopenscience/python:latest

# Install dependancies
RUN apt-get update \
  && apt-get install -y \
    git \
    libevent-dev \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
  && rm -rf /var/lib/apt/lists/*

ENV SOURCE_BRANCH=develop
ENV SOURCE_REPO=https://github.com/CenterForOpenScience/waterbutler.git

RUN git clone -b $SOURCE_BRANCH $SOURCE_REPO .
RUN pip install -U -r requirements.txt
RUN python setup.py develop
RUN chown -R python /code

VOLUME ["/data/osfstorage/pending", "/data/osfstorage/complete"]

# Replace the entrypoint script with our tornado specific script.
COPY docker-entrypoint.sh /

CMD ["/bin/bash"]
