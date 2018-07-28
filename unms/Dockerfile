FROM mhart/alpine-node:9.1.0
LABEL maintainer="Nick Van Wiggeren <me@nvw.io>"

# Add s6-init so we can get this crap running
ADD https://github.com/just-containers/s6-overlay/releases/download/v1.21.4.0/s6-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C /

# Add Dependencies - most of these will be removed later
RUN devDeps="wget openssl-dev pcre-dev zlib-dev build-base libffi-dev python-dev build-base vips-dev fftw-dev make g++ su-exec gzip bash vim libcap sudo openssl pcre libgcc gettext" \
  && echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
  && echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
  && echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
  && apk add --no-cache ${devDeps} rabbitmq-server vips postgresql redis ca-certificates python \
  && deluser rabbitmq \
  && addgroup -S rabbitmq && adduser -S -h /var/lib/rabbitmq -G rabbitmq rabbitmq \
  && echo $(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1) >> /var/lib/rabbitmq/.erlang.cookie

# Copy the UNMS source code over
COPY unms12/ unms/
COPY root /

RUN cd /unms && npm install && apk del ${devDeps}
VOLUME ["/config"]
EXPOSE 8081 8082

ENV PGDATA=/config/pg \
  POSTGRES_DB=unms \
  PATH=/unms/node_modules/.bin:$PATH \
  PUBLIC_HTTPS_PORT=443 \
  PUBLIC_WS_PORT=443 \
  SECURE_LINK_SECRET=supersecure

ENTRYPOINT ["/init"]
