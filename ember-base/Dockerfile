FROM node

RUN apt-get update \
    && apt-get install -y \
        apt-transport-https \
        ca-certificates \
    && for url in \
        https://dl.yarnpkg.com/debian/pubkey.gpg \
        https://dl.google.com/linux/linux_signing_key.pub \
    ; do \
        curl -sS ${url} | apt-key add - \
    ; done \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update \
    && apt-get install -y \
        yarn \
        google-chrome-stable \
        libdbus-glib-1-2 \
        libpango1.0-0 \
        "gtk+3.0" \
        build-essential \
        automake \
        autoconf \
        python-dev \
    && curl -sLo /tmp/firefox.tar.bz2 "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US" \
    && tar -C /opt -xjf /tmp/firefox.tar.bz2 \
    && rm /tmp/firefox.tar.bz2 \
    && ln -fs /opt/firefox/firefox /usr/bin/firefox \
    && export WATCHMAN_VERSION=4.9.0 \
    && git clone --branch v${WATCHMAN_VERSION} --single-branch https://github.com/facebook/watchman.git /tmp/watchman \
    && cd /tmp/watchman \
    && ./autogen.sh \
    && ./configure --enable-statedir=/tmp \
    && make \
    && make install \
    && mv watchman /usr/local/bin/watchman \
    && rm -Rf /tmp/watchman \
    && apt-get remove -y \
        build-essential \
        automake \
        autoconf \
        python-dev \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /code

WORKDIR /code
