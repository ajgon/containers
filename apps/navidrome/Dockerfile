ARG VERSION
FROM public.ecr.aws/docker/library/golang:1.20-alpine as builder

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

WORKDIR /app

#hadolint ignore=DL3018
RUN apk add --no-cache --update alpine-sdk bash git nodejs npm taglib-dev zlib-dev \
 && git clone --branch "v${VERSION}" --depth 1 https://github.com/navidrome/navidrome /app \
 && sed -i'' 's@/ping@/-/healthz@g' ./server/server.go \
 && sh -c 'cd ui && npm install' \
 && bash -c 'IFS=/ read -r GOOS GOARCH <<< "${TARGETPLATFORM}" && make buildall'

FROM ghcr.io/ajgon/alpine:3.17.2

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

ENV ND_DATAFOLDER=/config \
    ND_LOGLEVEL=info \
    ND_MUSICFOLDER=/music \
    ND_PORT=3000 \
    ND_SCANINTERVAL=1m \
    ND_SESSIONTIMEOUT=30m \
    ND_TRANSCODINGCACHESIZE=100MB

#hadolint ignore=DL3018
RUN apk --no-cache add ffmpeg taglib

USER abc
COPY --chmod=0755 --chown=1000:1000 entrypoint.sh /usr/local/bin/entrypoint.sh
COPY --from=builder /app/navidrome /usr/bin/navidrome

EXPOSE 3000
VOLUME ["/config", "/music"]
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/base-entrypoint.sh", "/usr/local/bin/entrypoint.sh"]
CMD ["/usr/bin/navidrome", "--datafolder", "/config", "--musicfolder", "/music"]

LABEL org.opencontainers.image.source="https://github.com/navidrome/navidrome/"
