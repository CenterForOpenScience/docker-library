FROM rabbitmq:latest

# Workaround for VirtualBox disk mounting issue.
# https://github.com/boot2docker/boot2docker/issues/581#issuecomment-68227494
RUN usermod -u 1000 rabbitmq

# Temporary fix while waiting for version to bump so PR merge is included.
# https://github.com/docker-library/rabbitmq/commit/a5f531284b81765b5762905909d43c74e5f80795
RUN echo '[{rabbit, [{loopback_users, []}]}].' > /etc/rabbitmq/rabbitmq.config
