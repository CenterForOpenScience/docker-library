#########################################
# Dockerfile to setup GNU Mailman Suite
#########################################

FROM python:2.7

# File Author / Maintainer
MAINTAINER Joshua Bird

RUN apt-get update
RUN apt-get install -y nginx

RUN apt-get install -y rsync bash
RUN apt-get install -y vim
RUN apt-get install -y git python3.4-dev python-dev python-pip python-virtualenv
RUN apt-get install -y nodejs npm && \
    npm install -g less && \
        ln -s /usr/bin/nodejs /usr/bin/node
RUN apt-get install -y ruby-full rubygems
RUN gem install sass
RUN apt-get install -y postgresql
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install postfix
RUN apt-get install -y libsasl2-modules

# get mailman-bundler
WORKDIR /mailman3
RUN git clone https://gitlab.com/mailman/mailman-bundler.git
RUN pip install zc.buildout
WORKDIR /mailman3/mailman-bundler


RUN buildout
RUN virtualenv venv
RUN . venv/bin/activate

# Expose ports
EXPOSE 8000
EXPOSE 8001

ENTRYPOINT /mailman3/scripts/run
