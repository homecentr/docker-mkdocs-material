FROM squidfunk/mkdocs-material:5.3.2 as material

FROM ubuntu:bionic

LABEL maintainer="Lukas Holota <me@lholota.com>"
LABEL io.homecentr.dependency-version=5.1.1

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

ADD https://raw.githubusercontent.com/squidfunk/mkdocs-material/master/requirements.txt /tmp/requirements.txt
ADD https://github.com/jgraph/drawio-desktop/releases/download/v12.9.13/draw.io-amd64-12.9.13.deb /tmp/drawio.deb

COPY --from=material /usr/local/bin/mkdocs /usr/local/bin/mkdocs

    # Install the downloaded package and dependencies required for headless execution
    # hadolint ignore=DL3015,DL3008
RUN apt-get update && \
    apt-get install --no-install-recommends /tmp/drawio.deb -y && \
    apt-get install -y \
        libasound2 \
        xvfb \
        python3-pip \
        git && \
    # Clean up apt cache
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

RUN git clone https://github.com/squidfunk/mkdocs-material

WORKDIR /tmp/mkdocs-material

RUN pip3 install --no-cache-dir . && \
    pip3 install --no-cache-dir \
                mkdocs-drawio-exporter==0.6.1 \
                mkdocs-minify-plugin==0.3.0 \
                mkdocs-git-revision-date-localized-plugin==0.5.0 \
                mkdocs-awesome-pages-plugin==2.2.1 \
                git+git://github.com/andyoakley/mkdocs-jinja2@2a72c7dfad9d29b43f55f82f57c093023062a2e0

COPY ./entrypoint.sh /entrypoint.sh

RUN rm -rf /tmp/** && chmod a+x /entrypoint.sh

WORKDIR /docs

EXPOSE 8000

ENTRYPOINT [ "/entrypoint.sh" ]