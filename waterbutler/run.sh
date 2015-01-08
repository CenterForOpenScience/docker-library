# docker run \
#     -d \
#     -it \
#     --name waterbutler_data \
#     --volume ${PWD}/.data/rabbitmq/log:/data/rabbitmq/log \
#     --volume ${PWD}/.data/rabbitmq/mnesia:/data/rabbitmq/mnesia \
#     waterbutler_data

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

# docker run \
#     -d \
#     --name waterbutler_celery \
#     --volumes-from waterbutler_data \
#     -v $(pwd)/settings/local.py:/app/cloudstorm/settings/local.py:ro \
#     --link waterbutler_rabbitmq:rabbitmq \
#     --link waterbutler_redis:redis \
#     waterbutler_celery

docker run \
    -d \
    --name waterbutler_tornado \
    --env ENV=test \
    --volume ${HOME}/.cos/waterbutler-test.json:/home/docker/.cos/waterbutler-test.json:ro \
    --publish 7777:7777 \
    --link waterbutler_rabbitmq:rabbitmq \
    --link waterbutler_redis:redis \
    waterbutler_tornado
