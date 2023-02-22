# Cannot use golang 1.20 as quic-go is not compatible with it yet
# Also, upstream builds with Go 1.18, see https://github.com/AdguardTeam/dnsproxy/blob/master/.github/workflows/build.yaml
FROM --platform=$BUILDPLATFORM  golang:1.20.1 AS builder
ARG dnsproxy_version
ARG TARGETOS
ARG TARGETARCH
ENV CGO_ENABLED=0
WORKDIR /go/src/app
RUN git clone https://github.com/AdguardTeam/dnsproxy.git . --single-branch --branch $dnsproxy_version
RUN GOOS=$TARGETOS GOARCH=$TARGETARCH go build -mod=vendor -o /go/bin/dnsproxy .

FROM alpine:3.17.2
ENV ARGS=""
RUN apk add --update bind-tools
COPY --from=builder /go/bin/dnsproxy /
CMD /dnsproxy ${ARGS}
