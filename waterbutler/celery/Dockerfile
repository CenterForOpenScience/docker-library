FROM dockerfile/celery

# Install dependancies
RUN apt-get update \
    && apt-get install -y \
        git \
    && rm -rf /var/lib/apt/lists/*

# uid/gid are configured so subsequent containers can reuse the same account.
RUN groupadd -r docker -g 433 \
    && useradd -u 431 -r -g docker -d /home/docker -s /sbin/nologin -c "Docker user" docker \
    && mkdir /home/docker \
    && chown -R docker:docker /home/docker
ENV HOME /home/docker

# Add files.
ADD bin/docker-start /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-start

# Define working directory.
WORKDIR /app

# Allow docker to access specific folders
RUN mkdir -p /app /env
RUN chown -R docker:docker /app /env

# Switch to unprivileged docker user
USER docker

# Define mount points
VOLUME ["/data/log"]

# Startup script
CMD ["docker-start"]
