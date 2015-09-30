#!/bin/bash
set -e

chown -R www-data:www-data /home

if [[ $(stat -c '%U' /code) != www-data ]]; then
    chown -R www-data:www-data /code
fi

if [ ! -d /code/.git ]; then
    gosu www-data git init
fi

gosu www-data git remote rm origin || true
gosu www-data git remote add origin $SOURCE_REPO
gosu www-data git fetch -q
gosu www-data git checkout $SOURCE_BRANCH
gosu www-data git pull origin $SOURCE_BRANCH

# avoid running setup tasks on container restarts
commit_head=$(git rev-parse HEAD)
updated=false
if [ -f ".commit" ]; then
    if ! grep -Fxq "$commit_head" .commit; then
        updated=true
    fi
else
    updated=true
fi
if $updated; then
    if [ "$UPDATE_CMD" != "" ]; then
        echo "Updating: $UPDATE_CMD"
        # https://cosdev.readthedocs.org/en/latest/osf/common_problems.html#error-when-importing-uritemplate
        pip uninstall uritemplate.py --yes || true
        pip install uritemplate.py==0.3.0
        eval $UPDATE_CMD
    fi
fi
echo "$commit_head" > .commit

if [ "$1" = 'invoke' ]; then
    echo "Starting: $@"
    exec gosu www-data "$@"
fi

exec gosu root "$@"
