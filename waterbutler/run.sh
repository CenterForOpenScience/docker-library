docker run \
    -d \
    -it \
    --name waterbutler_data \
    --volume ${PWD}/.data/log:/data/log \
    --volume ${PWD}/.data/mnesia:/data/mnesia \
    waterbutler_data

docker run \
    -d \
    --name waterbutler_rabbitmq \
    --volumes-from waterbutler_data \
    waterbutler_rabbitmq

# docker run \
#     -d \
#     --name waterbutler_redis \
#     --volumes-from waterbutler_data \
#     dockerfile/redis

docker run \
    -d \
    --name waterbutler_tornado \
    --env ENV=test \
    --volume ${HOME}/.cos/waterbutler-test.json:/home/docker/.cos/waterbutler-test.json:ro \
    --publish 7777:7777 \
    --volumes-from waterbutler_data \
    waterbutler_tornado

    # --link waterbutler_rabbitmq:rabbitmq \
    # --link waterbutler_redis:redis \

# docker run \
#     -d \
#     --name waterbutler_celery \
#     --volumes-from waterbutler_data \
#     -v $(pwd)/settings/local.py:/app/cloudstorm/settings/local.py:ro \
#     --link waterbutler_rabbitmq:rabbitmq \
#     --link waterbutler_redis:redis \
#     waterbutler_celery


# docker run \
#     --name waterbutler_tornado \
#     -p 7777:7777 \
#     waterbutler_tornado
