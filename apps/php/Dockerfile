FROM ghcr.io/ajgon/alpine:3.17.1

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL
ENV PHP_VERSION=${VERSION}

#hadolint ignore=DL3018
RUN phpver="$(/bin/ash -o pipefail -c "echo '${PHP_VERSION}' | awk -F. '{ print \$1 \$2 }'")" \
 && apk --update add --no-cache \
    lighttpd \
    fcgi \
    "php${phpver}=${PHP_VERSION}" \
    "php${phpver}-cgi=${PHP_VERSION}" \
 && mkdir -p /run/lighttpd/ \
 && chown abc:abc /run/lighttpd/ \
 && chmod 777 "/etc/php${phpver}/conf.d/" \
 && echo 'error_log = /proc/self/fd/2' > "/etc/php${phpver}/conf.d/05_error_log.ini" \
 && echo 'catch_workers_output = yes' >> "/etc/php${phpver}/conf.d/05_error_log.ini" \
 && sed -i'' "s@##EXTRAS##@echo \"date.timezone = \\\\\"\${TZ}\\\\\"\" > /etc/php${phpver}/conf.d/10_timezone.ini\n\n##EXTRAS##@g" /usr/local/bin/base-entrypoint.sh

COPY lighttpd.conf /etc/lighttpd/lighttpd.conf

EXPOSE 3000
CMD ["/usr/sbin/lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
