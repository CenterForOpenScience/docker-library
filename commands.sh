A few notes to quickly get strated with docker.


--- Docker ---

docker run -d -p 5672:5672 -p 15672:15672 -v <log-dir>:/data/log -v <data-dir>:/data/mnesia dockerfile/rabbitmq
docker exec -it waterbutler_tornado_1 /bin/bash (bash shell on running container)


--- Docker Compose ---

docker run \
    -d \
    -it \
    --name waterbutler_data_1 \
    waterbutler_data

docker-compose build
docker-compose up
docker-compose run -d data


--- ZSH Shortcuts ---

https://github.com/icereval/dotfiles/blob/master/zsh/.zprezto/modules/docker/init.zsh

dsa (docker stop all containers)
drma (docker remove all containers)
drmi (docker remove all images)
drmin (docker remove all images w/o a tag, e.g. <none>)


--- Boot2Docker & VirtualBox Port Forwarding ---

VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port7777,tcp,,7777,,77777"


--- VirtualBox Port Forwarding (Vagrant) ---

## forward 7777 to local host for a specific virtual machine
VBoxManage controlvm boot2docker-vm natpf1 "waterbutler_tornado,tcp,127.0.0.1,7777,,7777"
