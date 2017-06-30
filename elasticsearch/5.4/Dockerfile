FROM elasticsearch:5.4.2

RUN bin/elasticsearch-plugin install x-pack
RUN bin/elasticsearch-plugin install io.fabric8:elasticsearch-cloud-kubernetes:5.4.2

ENV BOOTSTRAP_MEMORY_LOCK=false
ENV ES_JAVA_OPTS=-Djava.net.preferIPv4Stack=true

RUN apt-get update && apt-get install -y \
        jq \
        curl \
    && rm -rf /var/lib/apt/lists/*

# https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html#_c_customized_image
ADD elasticsearch.yml /usr/share/elasticsearch/config/
#RUN chown elasticsearch:elasticsearch config/elasticsearch.yml
