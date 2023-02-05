ARG VERSION
FROM public.ecr.aws/docker/library/alpine:3.17 as builder

ARG VERSION
ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT=""
ARG TARGETPLATFORM
ENV TARGETPLATFORM=${TARGETPLATFORM:-linux/amd64}
ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=${TARGETOS} \
    GOARCH=${TARGETARCH} \
    GOARM=${TARGETVARIANT} \
    GOPATH=/go
ENV PATH $GOPATH/bin:$PATH

#hadolint ignore=DL3018
RUN apk add --no-cache bash go upx \
 && bash -c 'IFS=/ read -r GOOS GOARCH <<< "${TARGETPLATFORM}" && go install -ldflags="-s -w" github.com/drone/envsubst/cmd/envsubst@latest' \
 && upx --ultra-brute /go/bin/envsubst


FROM public.ecr.aws/docker/library/alpine:${VERSION}

ARG VERSION
ARG TARGETPLATFORM
ENV TARGETPLATFORM=${TARGETPLATFORM:-linux/amd64}
ENV UMASK="0002" \
    TZ="Etc/UTC"

WORKDIR /app

# hadolint ignore=DL3002
USER root

#hadolint ignore=DL3018
RUN apk add --no-cache \
    bind-tools \
    ca-certificates \
    curl \
    iputils \
    jq \
    tini \
    tzdata

RUN addgroup -S abc --gid 1000 \
 && adduser -S abc -G abc --uid 1000 \
 && mkdir -p /config \
 && chown -R abc:abc /config \
 && chmod -R 775 /config \
 && printf "umask %d" "${UMASK}" > /etc/profile.d/umask.sh \
 && ln -s /usr/bin/vi   /usr/local/bin/vi \
 && ln -s /usr/bin/vi   /usr/local/bin/vim \
 && rm -rf /tmp/*

VOLUME ["/config"]
COPY --from=builder /go/bin/envsubst /usr/local/bin/envsubst
ENTRYPOINT ["/sbin/tini", "--"]
