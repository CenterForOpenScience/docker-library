FROM dockerfile/ubuntu

# Startup script
CMD ["/bin/bash"]

# Install dependancies
# RUN apt-get update \
#     && apt-get install -y \
#         git \
#     && rm -rf /var/lib/apt/lists/*

# uid/gid are configured so subsequent containers can reuse the same account.
# RUN groupadd -r docker -g 433 \
# 	&& useradd -u 431 -r -g docker -d /home/docker -s /bin/bash -c "Docker user" docker \
# 	&& mkdir /home/docker \
# 	&& chown -R docker:docker /home/docker
# ENV HOME /home/docker

# Define mount points.
VOLUME ["/data/log", "/data/mnesia"]

# Allow docker to access specific folders
# RUN mkdir -p /data/log /data/mnesia
# RUN chown -R docker:docker /data/log
# RUN chown -R rabbitmq:rabbitmq /data/mnesia
