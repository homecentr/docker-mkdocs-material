[![Project status](https://img.shields.io/badge/Project%20status-stable%20%26%20actively%20maintaned-green.svg)](https://github.com/homecentr/docker-mkdocs-material/graphs/commit-activity) 
[![](https://img.shields.io/github/issues-raw/homecentr/docker-mkdocs-material/bug?label=open%20bugs)](https://github.com/homecentr/docker-mkdocs-material/labels/bug) 
[![](https://images.microbadger.com/badges/version/homecentr/mkdocs-material.svg)](https://hub.docker.com/repository/docker/homecentr/mkdocs-material)
[![](https://img.shields.io/docker/pulls/homecentr/mkdocs-material.svg)](https://hub.docker.com/repository/docker/homecentr/mkdocs-material) 
[![](https://img.shields.io/docker/image-size/homecentr/mkdocs-material/latest)](https://hub.docker.com/repository/docker/homecentr/mkdocs-material)

![CI/CD on master](https://github.com/homecentr/docker-mkdocs/workflows/CI/CD%20on%20master/badge.svg)
![Regular Docker image vulnerability scan](https://github.com/homecentr/docker-mkdocs/workflows/Regular%20Docker%20image%20vulnerability%20scan/badge.svg)


# HomeCentr - mkdocs material
This docker image is an enriched version of the original [squidfunk's mkdocs-material](https://github.com/squidfunk/mkdocs-material) and adds [drawio-exporter](https://github.com/LukeCarrier/mkdocs-drawio-exporter) on top of that. The set up of the [drawio-exporter](https://github.com/LukeCarrier/mkdocs-drawio-exporter) and it's dependencies is not completely straightforward so I thought it could be also useful to others :wink:

## Usage

Update your mkdocs.yml file according to the guide in [drawio-exporter](https://github.com/LukeCarrier/mkdocs-drawio-exporter). Note that the container is running as root by default which means you have to add the `--no-sandbox` argument as shown below.

```yml
plugins:
  - drawio-exporter:
      drawio_args:
        - --no-sandbox
```

### Powershell

```Powershell
docker run --rm -it -p 8000:8000 -v ${$PWD}:/docs homecentr/mkdocs
```

### Bash

```Bash
docker run --rm -it -p 8000:8000 -v ${PWD}:/docs homecentr/mkdocs
```

## Exposed ports

| Port | Protocol | Description |
|------|------|-------------|
| 8000 | TCP | MkDocs development server |

## Volumes

| Container path| Description |
|------|-------------|
| /docs | Default working directory, this should be the directory with the mkdocs.yml file |

## Security 
The container is regularly scanned for vulnerabilities and updated. Further info can be found in the [Security tab](https://github.com/homecentr/docker-mkdocs/security).

### Container user
The container is tested to be running as a root. Given that it is a development container which should not be deployed anywhere and only used at build time this is an accepted feature.