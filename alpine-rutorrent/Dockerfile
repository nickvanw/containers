FROM alpine:latest
MAINTAINER Nick Van Wiggeren <nick@facepwn.com>

COPY nginx.conf config.php /tmp/
RUN addgroup -g 1000 rtorrent && adduser -D -u 1000 -G rtorrent rtorrent

RUN apk --no-cache add nginx php7-fpm php7-json php7 curl && \
	mkdir -p /run/nginx && \
	chmod ugo+w /run/nginx && \
	rm -f /etc/nginx/nginx.conf && \
	mkdir -p /etc/nginx/nginx.conf.d && \
	mkdir -p /var/www && \
	chown -R 755 /var/www/ && \
	chown -R rtorrent:rtorrent /var/www/ && \
	mv /tmp/nginx.conf /etc/nginx

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.21.4.0/s6-overlay-amd64.tar.gz /tmp/
RUN gunzip -c /tmp/s6-overlay-amd64.tar.gz | tar -xf - -C /


ADD https://github.com/Novik/ruTorrent/archive/v3.8.tar.gz /tmp/
RUN (gunzip -c /tmp/v3.8.tar.gz | tar -xf - -C /var/www) && \
	mv /var/www/ruTorrent-3.8 /var/www/rutorrent && \
	rm /var/www/rutorrent/conf/config.php && \
	mv /tmp/config.php /var/www/rutorrent/conf/ && \
	chown -R rtorrent:rtorrent /var/www/rutorrent
	

ENV UNWANTED_PLUGINS "extratio rssurlrewrite rss history xmpp ratio unpack datadir autotools trafic loginmgr create retrackers scheduler rutracker_check screenshots _task mediainfo"
RUN for plugin in $UNWANTED_PLUGINS; do rm -rf "/var/www/rutorrent/plugins/$plugin"; done

ADD init /etc/services.d/
ADD fix-attrs /etc/fix-attrs.d/

EXPOSE 9001 
ENTRYPOINT /init
