FROM node:14

RUN apt-get update \
    && apt-get install -y \
        apt-transport-https \
        ca-certificates \
    && curl -sS https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update \
    && apt-get install -y \
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
    && apt-get clean \
    && apt-get autoremove -y \
    build-essential \
    automake \
    autoconf \
    python-dev \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /code

WORKDIR /code
