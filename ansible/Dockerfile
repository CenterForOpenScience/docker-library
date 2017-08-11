FROM python:3-alpine

MAINTAINER Michael Haselton <michael@cos.io>

ARG VCS_REF
ARG BUILD_DATE

# Metadata
LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/centerforopenscience/docker-library/ansible" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.docker.dockerfile="/Dockerfile"

ENV ANSIBLE_VERSION="2.3.2"

RUN apk add --update ca-certificates \
 && apk add --update make gcc musl-dev python3-dev libffi-dev openssl-dev \
 && pip install cryptography \
 && pip install ansible==${ANSIBLE_VERSION} \
 && apk del make gcc musl-dev python3-dev libffi-dev openssl-dev \
 # && apk del --purge deps \
 && rm /var/cache/apk/*

ENTRYPOINT ["ansible"]
CMD ["--help"]
