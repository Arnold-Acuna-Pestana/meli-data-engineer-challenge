
FROM postgres:15

RUN apt-get update && \
    apt-get install -y postgresql-server-dev-15 build-essential git && \
    git clone --branch v1.5.2 https://github.com/citusdata/pg_cron.git /pg_cron && \
    cd /pg_cron && \
    make && make install && \
    rm -rf /pg_cron

COPY init_pgcron.sql /docker-entrypoint-initdb.d/
