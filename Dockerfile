FROM --platform=$BUILDPLATFORM  golang:1.27.1@sha256:162be5298a40ed317005c8339c6de4d10d3eef336d66dc8e9259b03ab9d3a6d2 AS builder
ARG dnsproxy_version
ARG TARGETOS
ARG TARGETARCH
ENV CGO_ENABLED=0
WORKDIR /go/src/app
RUN git clone https://github.com/AdguardTeam/dnsproxy.git . --single-branch --branch $dnsproxy_version
RUN GOOS=$TARGETOS GOARCH=$TARGETARCH go build -o /go/bin/dnsproxy .

FROM alpine:3.24.2@sha256:294b683cb724975bec92580e1e685676bd4b50bda910ddb8c51d4cabeaec77e6
ENV ARGS=""
RUN apk add --update bind-tools
COPY --from=builder /go/bin/dnsproxy /
SHELL ["/bin/sh", "-c"]
CMD /dnsproxy ${ARGS}
