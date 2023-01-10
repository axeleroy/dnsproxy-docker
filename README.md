# DNS Proxy Docker
A dead-simple, multi-arch Docker image for [AdguardTeam/dnsproxy](https://github.com/AdguardTeam/dnsproxy). Supports DNS-over-TLS, DNS-over-HTTPS, DNS-over-QUIC and DNSCrypt. 

[![Docker Hub](https://img.shields.io/docker/v/axeleroy/dnsproxy?sort=semver&logo=docker)](https://hub.docker.com/r/axeleroy/dnsproxy/tags)
[![Docker build](https://github.com/axeleroy/dnsproxy-docker/actions/workflows/publish.yml/badge.svg)](https://github.com/axeleroy/dnsproxy-docker/actions/workflows/publish.yml)

## Usage

**TL;DR:** start the container and put the arguments for the `dnsproxy` command in the `ARGS` environment
variable. Details on the arguments and examples can be found in the
[original repo](https://github.com/AdguardTeam/dnsproxy#usage).

### Vanilla Docker
```console
docker run -d \
  -e "ARGS=-u 8.8.8.8:53 -u 1.1.1.1:53 --cache" \
  -p 53:53 \
  axeleroy/dnsproxy:latest
```

### Docker Compose

```yaml
version: "3"
services:
  dnsproxy:
    image: axeleroy/axeleroy/dnsproxy:latest
    environment:
      - ARGS=-u 8.8.8.8:53 -u 1.1.1.1:53 --cache 
    ports:
      - "53:53"
```

### DNS-over-TLS and DNS-over-HTTPS with Pi-hole and unbound

I made an [example Docker Compose stack](https://github.com/axeleroy/dnsproxy-docker/blob/main/docker-compose-pihole.yml)
that shows you how to set up a Pi-hole using unbound as its upstream DNS server with DNS-over-TLS and DNS-over-HTTPS
capabilities.

## Building the image

Simply run the `docker build` command and specify the desired version in the `dnsproxy_version` argument.

```console
docker build --build-arg dnsproxy_version=v0.46.5 -t axeleroy/dnsproxy:custom .
```
