FROM debian:sid

COPY sources.list /etc/apt/sources.list
COPY apt.conf /etc/apt/apt.conf.d/60docker

RUN \
    apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get build-dep -y openjdk-9 && \
    apt-get clean

RUN \
    apt-get source openjdk-9

WORKDIR /openjdk-9-9~b177

COPY disable-doclint-by-default.diff debian/patches/

RUN \
    DEB_BUILD_OPTIONS=nocheck dpkg-buildpackage -us -uc -b
