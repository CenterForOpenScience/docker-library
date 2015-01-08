docker run \
    -d \
    -it \
    --name waterbutler_data \
    --volume ${PWD}/.data/tornado/complete:/data/complete \
    --volume ${PWD}/.data/tornado/pending:/data/pending \
    waterbutler_data

docker run \
    -d \
    --name waterbutler_redis \
    --volume ${PWD}/.data/redis/data:/data \
    waterbutler_redis

docker run \
    -d \
    --name waterbutler_rabbitmq \
    --volume ${PWD}/.data/rabbitmq/log:/data/log \
    --volume ${PWD}/.data/rabbitmq/mnesia:/data/mnesia \
    --link waterbutler_redis:redis \
    waterbutler_rabbitmq

docker run \
    -d \
    --name waterbutler_tornado \
    --env ENV=test \
    --volume ${HOME}/.cos/waterbutler-test.json:/home/docker/.cos/waterbutler-test.json:ro \
    --volumes-from waterbutler_data \
    --publish 7777:7777 \
    --link waterbutler_rabbitmq:rabbitmq \
    waterbutler_tornado
