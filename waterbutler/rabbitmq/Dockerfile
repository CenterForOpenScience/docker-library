FROM dockerfile/rabbitmq

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

# Workaround for VirtualBox disk mountin issue.
# https://github.com/boot2docker/boot2docker/issues/581#issuecomment-68227494
RUN usermod -u 1000 rabbitmq
