#docker run -d -p 5672:5672 -p 15672:15672 -v <log-dir>:/data/log -v <data-dir>:/data/mnesia dockerfile/rabbitmq

# boot2docker forward 7777 to local host
# VBoxManage controlvm boot2docker-vm natpf1 "waterbutler_tornado,tcp,127.0.0.1,7777,,7777"
# VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port7777,tcp,,7777,,77777"

docker build -t waterbutler_data ./data
docker build -t waterbutler_celery ./celery
docker build -t waterbutler_tornado ./tornado

-------------------------------------------------

docker run \
    -d \
    -it \
    --name waterbutler_data_1 \
    waterbutler_data

fig build
fig up
fig run -d data

-------------------------------------------------

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
    --d \
    -it \
    --name waterbutler_data \
    waterbutler_data
# docker run \
#     -d \
#     --name waterbutler_rabbitmq \
#     --volumes-from waterbutler_data \
#     dockerfile/rabbitmq
# docker run \
#     -d \
#     --name waterbutler_redis \
#     --volumes-from waterbutler_data \
#     dockerfile/redis
docker run \
    -d \
    --name waterbutler_tornado \
    --emv ENV=test
    --volume ~/.cos/waterbutler-test.json:/home/docker/.cos/waterbutler-test.json:ro \
    --publish 7777:7777 \
    --volumes-from waterbutler_data \
    --link waterbutler_rabbitmq:rabbitmq \
    --link waterbutler_redis:redis \
    waterbutler_tornado
docker run \
    -d \
    --name waterbutler_celery \
    --volumes-from waterbutler_data \
    -v $(pwd)/settings/local.py:/app/cloudstorm/settings/local.py:ro \
    --link waterbutler_rabbitmq:rabbitmq \
    --link waterbutler_redis:redis \
    waterbutler_celery


docker run \
    --name waterbutler_tornado \
    -p 7777:7777 \
    waterbutler_tornado
