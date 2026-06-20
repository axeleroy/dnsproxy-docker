FROM --platform=$BUILDPLATFORM  golang:1.26.4@sha256:68cb6d68bed024785b69195b89af7ac7a444f27791435f98647edff595aa0479 AS builder
ARG dnsproxy_version
ARG TARGETOS
ARG TARGETARCH
ENV CGO_ENABLED=0
WORKDIR /go/src/app
RUN git clone https://github.com/AdguardTeam/dnsproxy.git . --single-branch --branch $dnsproxy_version
RUN GOOS=$TARGETOS GOARCH=$TARGETARCH go build -o /go/bin/dnsproxy .

FROM alpine:3.24.1@sha256:28bd5fe8b56d1bd048e5babf5b10710ebe0bae67db86916198a6eec434943f8b
ENV ARGS=""
RUN apk add --update bind-tools
COPY --from=builder /go/bin/dnsproxy /
SHELL ["/bin/sh", "-c"]
CMD /dnsproxy ${ARGS}
