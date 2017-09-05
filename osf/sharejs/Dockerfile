FROM node:0.12

ENV SOURCE_BRANCH develop
ENV SOURCE_REPO https://github.com/CenterForOpenScience/osf.io.git

RUN mkdir -p /code
WORKDIR /code

RUN mkdir -p /tmp/source \
    && cd /tmp/source \
    && git clone $SOURCE_REPO --branch $SOURCE_BRANCH --single-branch . \
    && cd addons/wiki \
    && cp shareServer.js package.json /code \
    && rm -rf /tmp/source

ENV NODE_ENV production
RUN npm install

EXPOSE 7007
VOLUME /code

CMD ["node", "./shareServer.js"]
