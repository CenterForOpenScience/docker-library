#!/bin/bash
set -e

mkdir -p $WORKDIR
cd $WORKDIR

chown -R www-data:www-data /home || true
chown -R www-data:www-data $WORKDIR || true

if [ ! -d $WORKDIR/.git ]; then
    gosu www-data git init
fi

gosu www-data git remote rm origin || true
gosu www-data git remote add origin $SOURCE_REPO
gosu www-data git remote set-url origin $SOURCE_REPO
gosu www-data git fetch
gosu www-data git checkout $SOURCE_BRANCH
gosu www-data git pull origin $SOURCE_BRANCH

# avoid running setup tasks on container restarts
commit_head=$(git rev-parse HEAD)
# ember builds use GIT_COMMIT for cache busting
export GIT_COMMIT=$commit_head
updated=false
if [ -f "/tmp/.commit" ]; then
    if ! grep -Fxq "$commit_head" /tmp/.commit; then
        updated=true
    fi
else
    updated=true
fi
if $updated; then
    if [ "$UPDATE_CMD" != "" ]; then
        echo "Updating: $UPDATE_CMD"
        eval $UPDATE_CMD
    fi
fi
echo "$commit_head" > /tmp/.commit

if [ "$1" = 'invoke' ]; then
    echo "Starting: $@"
    exec gosu www-data "$@"
fi

exec gosu root "$@"
