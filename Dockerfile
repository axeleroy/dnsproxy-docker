FROM golang:1.19.4 AS builder
ARG dnsproxy_version
WORKDIR /go/src/app
ENV CGO_ENABLED=0
RUN git clone https://github.com/AdguardTeam/dnsproxy.git . --single-branch --branch $dnsproxy_version
RUN go build -mod=vendor -o /go/bin/dnsproxy .

FROM alpine:3.17.0
ENV ARGS=""
COPY --from=builder /go/bin/dnsproxy /
CMD /dnsproxy ${ARGS}
