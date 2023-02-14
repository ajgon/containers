FROM ghcr.io/ajgon/alpine:3.17.2

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

#hadolint ignore=DL3018
RUN case "${TARGETPLATFORM}" in \
        'linux/amd64') export ARCH='x86_64' ;; \
        'linux/arm64') export ARCH='aarch64' ;; \
    esac \
 && wget -q -O /tmp/python2.apk "https://dl-cdn.alpinelinux.org/alpine/v3.15/community/${ARCH}/python2-2.7.18-r4.apk" \
 && wget -q -O /tmp/python2-dev.apk "https://dl-cdn.alpinelinux.org/alpine/v3.15/community/${ARCH}/python2-dev-2.7.18-r4.apk" \
 && apk del --purge openssl \
 && apk add /tmp/python2.apk libpq libstdc++ --allow-untrusted --no-cache \
 && apk add /tmp/python2-dev.apk build-base gcc git libffi-dev musl-dev --allow-untrusted --no-cache --virtual .build-deps \
 && /bin/ash -o pipefail -c 'curl https://bootstrap.pypa.io/pip/2.7/get-pip.py | python' \
 && apk add openssl1.1-compat-dev --no-cache \
 && pip install --no-cache-dir cryptography==2.6.1 \
 && apk del --purge openssl1.1-compat-dev \
 && apk add mariadb-dev postgresql-dev --no-cache --virtual .extra-deps \
 && git clone https://github.com/mozilla-services/syncserver \
 && sed -E -i'' 's@(config.add_view.*$)@\1\n    config.add_route("healthcheck", "/-/healthz")\n    config.add_view(itworks, route_name="healthcheck")@g' /app/syncserver/syncserver/__init__.py \
 && pip install --no-cache-dir -r syncserver/requirements.txt \
 && sh -c 'cd syncserver && python setup.py develop' \
 && apk del --purge .build-deps .extra-deps \
 && pip uninstall pip --yes \
 && rm -rf /tmp/python2.apk /tmp/python2-dev.apk

#USER abc
COPY --chmod=0755 --chown=1000:1000 entrypoint.sh /usr/local/bin/entrypoint.sh

EXPOSE 3000
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/base-entrypoint.sh", "/usr/local/bin/entrypoint.sh"]
CMD ["/usr/bin/gunicorn", "--bind", "0.0.0.0:3000", "--forwarded-allow-ips=\"*\"", "syncserver.wsgi_app"]

LABEL org.opencontainers.image.source="https://github.com/mozilla-services/syncserver/"
