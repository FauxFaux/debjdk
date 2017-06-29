FROM debian:sid

COPY sources.list /etc/apt/sources.list
COPY apt.conf /etc/apt/apt.conf.d/60docker

RUN \
    apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y --no-install-recommends build-essential openjdk-9-jdk && \
    apt-get clean

COPY to-jdk-9_1.0_all.deb /

RUN \
    dpkg -i to-jdk-9_1.0_all.deb && \
    rm to-jdk-9_1.0_all.deb

RUN \
    apt-get install -y maven-debian-helper
