#docker run -d -p 5672:5672 -p 15672:15672 -v <log-dir>:/data/log -v <data-dir>:/data/mnesia dockerfile/rabbitmq

# boot2docker forward 7777 to local host
# VBoxManage controlvm boot2docker-vm natpf1 "waterbutler_tornado,tcp,127.0.0.1,7777,,7777"
# VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port7777,tcp,,7777,,77777"

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
