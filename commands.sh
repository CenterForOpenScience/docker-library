#docker run -d -p 5672:5672 -p 15672:15672 -v <log-dir>:/data/log -v <data-dir>:/data/mnesia dockerfile/rabbitmq

# boot2docker forward 7777 to local host
VBoxManage controlvm boot2docker-vm natpf1 "osfuploadservice-tornado,tcp,127.0.0.1,7777,,7777"

docker build -t waterbutler-data ./waterbutler/data
docker build -t waterbutler-celery ./waterbutler/celery
docker build -t waterbutler-tornado ./waterbutler/tornado

-------------------------------------------------

fig build
fig up
dsa
drma
drmin
docker exec -it waterbutler_tornado_1 bash

-------------------------------------------------

# docker run \
# 	-d \
# 	--name waterbutler-data \
# 	-v <log-dir>:/data/log \
# 	-v <data-dir>:/data/mnesia \
# 	waterbutler-data
docker run \
    -d \
    -it \
    --name waterbutler-data \
    waterbutler-data
docker run \
    -d \
    --name waterbutler-rabbitmq \
    --volumes-from waterbutler-data \
    dockerfile/rabbitmq
docker run \
    -d \
    --name waterbutler-redis \
    --volumes-from waterbutler-data \
    dockerfile/redis
docker run \
    -d \
    --name waterbutler-tornado \
    --volumes-from waterbutler-data \
    -v $(pwd)/settings/local.py:/app/cloudstorm/settings/local.py:ro \
    -p 7777:7777 \
    --link waterbutler-rabbitmq:rabbitmq \
    --link waterbutler-redis:redis \
    waterbutler-tornado
docker run \
    -d \
    --name waterbutler-celery \
    --volumes-from waterbutler-data \
    -v $(pwd)/settings/local.py:/app/cloudstorm/settings/local.py:ro \
    --link waterbutler-rabbitmq:rabbitmq \
    --link waterbutler-redis:redis \
    waterbutler-celery
