FROM docker.elastic.co/elasticsearch/elasticsearch:6.4.1

USER root

# https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html#_c_customized_image
ADD elasticsearch.yml /usr/share/elasticsearch/config/
RUN chown elasticsearch:elasticsearch config/elasticsearch.yml

USER elasticsearch

RUN bin/elasticsearch-plugin install -b com.floragunn:search-guard-6:6.4.1-23.1
