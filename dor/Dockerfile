FROM centerforopenscience/uwsgi:2.7

ENV SOURCE_BRANCH=develop
ENV SOURCE_REPO=https://github.com/mfraezz/DirectoryOfRepositories.git

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

VOLUME ["/code", "/log"]

CMD ["uwsgi", "--ini", "/etc/uwsgi/uwsgi.ini"]
