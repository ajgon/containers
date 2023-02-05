FROM ghcr.io/ajgon/alpine:3.17.1

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

#hadolint ignore=DL3018
RUN ver="$(/bin/ash -o pipefail -c "echo '${VERSION}' | awk -F. '{ print \$1 \$2 }'")" \
 && apk add --no-cache \
    lighttpd \
    fcgi \
    "php${ver}=${VERSION}"\
    "php${ver}-calendar=${VERSION}"\
    "php${ver}-cgi=${VERSION}"\
    "php${ver}-common=${VERSION}"\
    "php${ver}-ctype=${VERSION}"\
    "php${ver}-curl=${VERSION}"\
    "php${ver}-dom=${VERSION}"\
    "php${ver}-gd=${VERSION}"\
    "php${ver}-gettext=${VERSION}"\
    "php${ver}-iconv=${VERSION}"\
    "php${ver}-imap=${VERSION}"\
    "php${ver}-intl=${VERSION}"\
    "php${ver}-ldap=${VERSION}"\
    "php${ver}-openssl=${VERSION}"\
    "php${ver}-pdo=${VERSION}"\
    "php${ver}-pdo_pgsql=${VERSION}"\
    "php${ver}-pgsql=${VERSION}"\
    "php${ver}-posix=${VERSION}"\
    "php${ver}-session=${VERSION}"\
    "php${ver}-simplexml=${VERSION}"\
    "php${ver}-soap=${VERSION}"\
    "php${ver}-xml=${VERSION}"\
 && mkdir -p /run/lighttpd/ \
 && chown abc:abc /run/lighttpd/

COPY lighttpd.conf /etc/lighttpd/lighttpd.conf

EXPOSE 3000
CMD ["/usr/sbin/lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
