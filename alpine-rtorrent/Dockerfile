FROM alpine:latest
MAINTAINER Nick Van Wiggeren <nick@facepwn.com>

RUN addgroup -g 1000 rtorrent && adduser -D -u 1000 -G rtorrent rtorrent
RUN apk --no-cache add rtorrent dtach 

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.21.4.0/s6-overlay-amd64.tar.gz /tmp/
RUN gunzip -c /tmp/s6-overlay-amd64.tar.gz | tar -xf - -C /

ADD init /etc/services.d/
ADD fix-attrs /etc/fix-attrs.d/

ENV TERM xterm

EXPOSE 63256
VOLUME ["/data"]
ENTRYPOINT /init
