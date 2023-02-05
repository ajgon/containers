FROM ghcr.io/ajgon/alpine:3.17.1

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

#hadolint ignore=DL3018
RUN apk add --no-cache \
    lighttpd \
    fcgi \
    php \
    php-calendar \
    php-cgi \
    php-common \
    php-ctype \
    php-curl \
    php-dom \
    php-gd \
    php-gettext \
    php-iconv \
    php-imap \
    php-intl \
    php-ldap \
    php-openssl \
    php-pdo \
    php-pdo_pgsql \
    php-pgsql \
    php-posix \
    php-session \
    php-simplexml \
    php-soap \
    php-xml \
 && mkdir -p /run/lighttpd/ \
 && chown abc:abc /run/lighttpd/

COPY lighttpd.conf /etc/lighttpd/lighttpd.conf

EXPOSE 3000
CMD ["/usr/sbin/lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
