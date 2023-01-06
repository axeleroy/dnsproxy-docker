# DNS Proxy Docker
A dead-simple, multi-arch Docker image for [AdguardTeam/dnsproxy](https://github.com/AdguardTeam/dnsproxy).

[![Docker Hub](https://img.shields.io/docker/v/axeleroy/dnsproxy?sort=semver&logo=docker)](https://hub.docker.com/r/axeleroy/dnsproxy/tags)
[![Docker build](https://github.com/axeleroy/dnsproxy-docker/actions/workflows/publish.yml/badge.svg)](https://github.com/axeleroy/dnsproxy-docker/actions/workflows/publish.yml)

## Usage

**TL;DR:** start the container and put the arguments for the `dnsproxy` command in the `ARGS` environment
variable. Details on the arguments and examples can be found in the
[original repo](https://github.com/AdguardTeam/dnsproxy#usage).

### Vanilla Docker
```console
docker run -d \
  -e "ARGS=-u 8.8.8.8:53 -v -o /dev/stdout" \
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
      - ARGS=-u 8.8.8.8:53 -v -o /dev/stdout
    ports:
      - "53:53"
```

## Building the image

Simply run the `docker build` command and specify the desired version in the `dnsproxy_version` argument.

```console
docker build --build-arg dnsproxy_version=v0.46.5 -t axeleroy/dnsproxy:custom .
```
