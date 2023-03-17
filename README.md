# DNS Proxy Docker
A dead-simple, multi-arch Docker image for [AdguardTeam/dnsproxy](https://github.com/AdguardTeam/dnsproxy). Supports DNS-over-TLS, DNS-over-HTTPS, DNS-over-QUIC and DNSCrypt. 

[Releases are automated](https://github.com/axeleroy/dnsproxy-docker/actions/workflows/auto-release.yml) and published
in the 24 hours following a new version of DNS Proxy.

[![Docker Hub](https://img.shields.io/docker/v/axeleroy/dnsproxy?sort=semver&logo=docker)](https://hub.docker.com/r/axeleroy/dnsproxy/tags)
[![Docker Hub](https://img.shields.io/docker/pulls/axeleroy/dnsproxy?logo=docker)](https://hub.docker.com/r/axeleroy/dnsproxy/tags)
[![GitHub release](https://img.shields.io/github/v/release/axeleroy/dnsproxy-docker?logo=github&logoColor=959DA5)](https://github.com/axeleroy/dnsproxy-docker/packages)
[![GitHub release](https://img.shields.io/github/downloads/axeleroy/dnsproxy-docker/total?color=%230b7cbc&logo=github&logoColor=959DA5)](https://github.com/axeleroy/dnsproxy-docker/packages)

[![Docker build](https://github.com/axeleroy/dnsproxy-docker/actions/workflows/auto-release.yml/badge.svg)](https://github.com/axeleroy/dnsproxy-docker/actions/workflows/auto-release.yml)

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
    image: ghcr.io/axeleroy/dnsproxy:latest
    environment:
      - ARGS=-u 8.8.8.8:53 -u 1.1.1.1:53 --cache 
    ports:
      - "53:53"
```

### DNS-over-TLS and DNS-over-HTTPS with Pi-hole and unbound

I made an [example Docker Compose stack](https://github.com/axeleroy/dnsproxy-docker/blob/main/docker-compose-pihole.yml)
that shows you how to set up Pi-hole using unbound as its upstream DNS server with DNS-over-TLS and DNS-over-HTTPS
capabilities (for using your Pi-hole outside your home on your mobile devices).

## Building the image

Simply run the `docker build` command and specify the desired version in the `dnsproxy_version` argument.

```console
docker build --build-arg dnsproxy_version=v0.46.5 -t axeleroy/dnsproxy:custom .
```
