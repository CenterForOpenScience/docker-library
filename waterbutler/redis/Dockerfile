FROM dockerfile/redis

# Define default command.
CMD ["docker-start"]

# Add files.
ADD bin/docker-start /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-start

# Install dependancies
# RUN apt-get update \
#     && apt-get install -y \
#        git \
#     && rm -rf /var/lib/apt/lists/*
