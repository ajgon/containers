FROM ghcr.io/ajgon/php:8.1.15-r0

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

ENV APP_ENV=prod

#hadolint ignore=DL3018
RUN phpver="$(/bin/ash -o pipefail -c "echo '${PHP_VERSION}' | awk -F. '{ print \$1 \$2 }'")" \
 && apk --update add --no-cache \
        c-client \
        freetype \
        icu-libs \
        libjpeg-turbo \
        libldap \
        libpng \
        libpq \
        "php${phpver}-ctype=${PHP_VERSION}" \
        "php${phpver}-gd=${PHP_VERSION}" \
        "php${phpver}-imap=${PHP_VERSION}" \
        "php${phpver}-intl=${PHP_VERSION}" \
        "php${phpver}-ldap=${PHP_VERSION}" \
        "php${phpver}-pdo_pgsql=${PHP_VERSION}" \
        "php${phpver}-pgsql=${PHP_VERSION}" \
        "php${phpver}-session=${PHP_VERSION}" \
        "php${phpver}-simplexml=${PHP_VERSION}" \
        "php${phpver}-tokenizer=${PHP_VERSION}" \
        "php${phpver}-xml=${PHP_VERSION}" \
        "php${phpver}-xmlreader=${PHP_VERSION}" \
        "php${phpver}-xmlwriter=${PHP_VERSION}" \
 && wget -q -O /tmp/davis.tar.gz "https://github.com/tchapi/davis/archive/refs/tags/v${VERSION}.tar.gz" \
 && tar -xzvf /tmp/davis.tar.gz -C /app/ --strip-components=1 \
 && rm -rf /tmp/davis.tar.gz \
 && sed -i'' 's@path:.*@path: "php://stderr"@g' /app/config/packages/prod/monolog.yaml \
 && url="$(grep -E 'src="?http' ./templates/base.html.twig | sed -E 's@.*(http[^ "]+).*@\1@g')" \
 && wget -q -O "/app/public/js/$(basename ${url})" ${url} \
 && sed -i'' "s@${url}@/js/$(basename ${url})@g" ./templates/base.html.twig \
 && apk --update add --no-cache --virtual .build-deps composer \
 && composer install --no-ansi --no-dev --no-interaction --no-progress --optimize-autoloader \
 && apk del --purge .build-deps \
 && echo 'include "urls.conf"' >> /etc/lighttpd/lighttpd.conf \
 && chown -R abc:abc /app

USER abc
COPY --chmod=0755 --chown=1000:1000 entrypoint.sh /usr/local/bin/entrypoint.sh
COPY urls.conf /etc/lighttpd/urls.conf

ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/base-entrypoint.sh", "/usr/local/bin/entrypoint.sh"]
CMD ["/usr/sbin/lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]

LABEL org.opencontainers.image.source="https://github.com/tchapi/davis/"
