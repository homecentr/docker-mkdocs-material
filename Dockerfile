FROM squidfunk/mkdocs-material:5.3.3 as material

FROM ubuntu:bionic-20200713

LABEL maintainer="Lukas Holota <me@lholota.com>"
LABEL io.homecentr.dependency-version=5.1.1

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

ADD https://raw.githubusercontent.com/squidfunk/mkdocs-material/master/requirements.txt /tmp/requirements.txt
ADD https://github.com/jgraph/drawio-desktop/releases/download/v12.9.13/draw.io-amd64-12.9.13.deb /tmp/drawio.deb

COPY --from=material /usr/local/bin/mkdocs /usr/local/bin/mkdocs

    # Install the downloaded package and dependencies required for headless execution
    # hadolint ignore=DL3008
RUN apt-get update && \
    apt-get install --no-install-recommends /tmp/drawio.deb -y && \
    apt-get install -y --no-install-recommends \
        libasound2=1.1.3-5ubuntu0.5 \
        xvfb=2:1.19.6-1ubuntu4.4 \
        python3-pip=9.0.1-2.3~ubuntu1.18.04.1 \
        python3=3.6.7-1~18.04 \
        git=1:2.17.1-1ubuntu0.7 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

RUN git clone https://github.com/squidfunk/mkdocs-material

WORKDIR /tmp/mkdocs-material

RUN pip3 install --no-cache-dir setuptools==49.2.0 && \
    pip3 install --no-cache-dir . && \
    pip3 install --no-cache-dir \
                mkdocs-drawio-exporter==0.6.1 \
                mkdocs-minify-plugin==0.3.0 \
                mkdocs-git-revision-date-localized-plugin==0.5.0 \
                mkdocs-awesome-pages-plugin==2.2.1 \
                git+https://github.com/andyoakley/mkdocs-jinja2@2a72c7dfad9d29b43f55f82f57c093023062a2e0

COPY ./entrypoint.sh /entrypoint.sh

RUN rm -rf /tmp/** && chmod a+x /entrypoint.sh

RUN apt-get remove --purge -y binutils git perl patch openssl bzip2 procps glib-networking && \
    apt-get autoremove -y && \
    # Clean up apt cache
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /docs

EXPOSE 8000

ENTRYPOINT [ "/entrypoint.sh" ]