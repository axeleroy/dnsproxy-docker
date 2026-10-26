FROM --platform=$BUILDPLATFORM  golang:1.27.3@sha256:f20d83a83e18dbd2a4714b8ffd4b30b287b6243962dd75608e86abcc63ba4efc AS builder
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
