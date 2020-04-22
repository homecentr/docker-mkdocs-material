# HomeCentr - mkdocs
Used to generate the documentation site for Homecentr. The image contains [drawio-exporter](https://github.com/LukeCarrier/mkdocs-drawio-exporter) and all dependencies required for running from command line (i.e. in non-interactive environment). Since the set up is not completely straightforward, I thought it could be also useful to others :)

## Usage

### Powershell

```Powershell
docker run --rm -it -p 8000:8000 -v ${$PWD}:/docs homecentr/mkdocs
```

### Bash

```Bash
docker run --rm -it -p 8000:8000 -v ${PWD}:/docs homecentr/mkdocs
```

### Exposed ports

| Port | Description |
|------|-------------|
| 8000 | Development server |