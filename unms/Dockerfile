FROM ubnt/unms:0.13.2 as unms
FROM node:10-stretch-slim

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.21.8.0/s6-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C /

# Copy this from the unms container because the code is not public
COPY --from=unms /home/app/unms /unms
RUN rm -rf /unms/node_modules
COPY root /

# man page dir creation is a hack for postgres install
RUN apt-get update \
  && mkdir -p /usr/share/man/man1 \
  && mkdir -p /usr/share/man/man7 \
  && apt-get -y install python build-essential rabbitmq-server postgresql-9.6 postgresql-contrib-9.6 postgresql-client-9.6 libpq-dev redis-server
RUN cd /unms && npm install

VOLUME ["/config"]
EXPOSE 8081 8082

# We add postgres to the path so we can use the tools that underpin all the stuff
# debian adds, I really just want to use `initdb` and `postgres`
ENV PGDATA=/config/pg \
  UNMS_PG_USER=postgres \
  POSTGRES_DB=unms \
  UNMA_PG_DATABASE=unms \
  PATH=/unms/node_modules/.bin:$PATH:/usr/lib/postgresql/9.6/bin \
  PUBLIC_HTTPS_PORT=443 \
  PUBLIC_WS_PORT=443 \
  SECURE_LINK_SECRET=supersecure \
  UNMS_LOGGING=1

ENTRYPOINT ["/init"]
