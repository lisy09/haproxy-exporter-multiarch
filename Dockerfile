FROM alpine AS buildbox
ARG VERSION
ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT
RUN apk --no-cache add ca-certificates
RUN wget https://github.com/prometheus/haproxy_exporter/releases/download/v${VERSION}/haproxy_exporter-${VERSION}.${TARGETOS}-${TARGETARCH}${TARGETVARIANT}.tar.gz \
    -O /tmp/haproxy_exporter.tar.gz \
    && tar xvzf /tmp/haproxy_exporter.tar.gz \
    && mv haproxy*/haproxy_exporter /bin/

FROM quay.io/prometheus/busybox:latest
COPY --from=buildbox /bin/haproxy_exporter /bin/haproxy_exporter

USER nobody
ENTRYPOINT ["/bin/haproxy_exporter"]
EXPOSE 9101