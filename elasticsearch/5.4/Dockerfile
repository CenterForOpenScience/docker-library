FROM docker.elastic.co/elasticsearch/elasticsearch:5.4.0

RUN bin/elasticsearch-plugin install io.fabric8:elasticsearch-cloud-kubernetes:5.4.0

ENV BOOTSTRAP_MEMORY_LOCK=false
ENV ES_JAVA_OPTS=-Djava.net.preferIPv4Stack=true

# common dependencies
USER root
RUN yum -y update \
    && yum install -y \
        jq \
        curl \
    && yum clean all

# https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html#_c_customized_image
ADD elasticsearch.yml /usr/share/elasticsearch/config/
RUN chown elasticsearch:elasticsearch config/elasticsearch.yml

USER elasticsearch
