ARG VERSION
FROM public.ecr.aws/docker/library/golang:1.20-alpine as builder

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

WORKDIR /app

#hadolint ignore=DL3018
RUN apk add --no-cache --update git \
 && git clone --branch "${VERSION}" --depth 1 https://github.com/miniflux/v2 /app \
 && sed -i'' 's@/healthcheck@/-/healthz@g' ./cli/health_check.go \
 && sed -i'' 's@/healthcheck@/-/healthz@g' ./service/httpd/httpd.go \
 && go build \
    -o miniflux \
    -ldflags="-s -w -X 'miniflux.app/version.Version=$(git describe --tags --abbrev=0)' -X 'miniflux.app/version.Commit=$(git rev-parse --short HEAD)' -X 'miniflux.app/version.BuildDate=$(date +%FT%T%z)'" \
    main.go

FROM ghcr.io/ajgon/alpine:3.17.2

ENV LISTEN_ADDR 0.0.0.0:3000

#hadolint ignore=DL3018
RUN apk --no-cache add ca-certificates tzdata

USER abc
COPY --chmod=0755 --chown=1000:1000 entrypoint.sh /usr/local/bin/entrypoint.sh
COPY --from=builder /app/miniflux /usr/bin/miniflux

EXPOSE 3000
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/base-entrypoint.sh", "/usr/local/bin/entrypoint.sh"]
CMD ["/usr/bin/miniflux"]
