FROM debian:sid

COPY sources.list /etc/apt/sources.list
COPY apt.conf /etc/apt/apt.conf.d/60docker

RUN \
    apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y --no-install-recommends build-essential debhelper openjdk-9-jdk && \
    apt-get clean

RUN \
    apt-get source java-common && \
    cd java-common-* && \
    sed -i 's/java9_architectures =/& amd64/' debian/java_defaults.mk && \
    dpkg-buildpackage -us -uc -b && \
    dpkg -i ../default-j[dr]*.deb ../java-common*.deb; \
    rm -rf ../java-common* ../*.deb && \
    apt-get install -y -f && \
    apt-get clean

COPY to-jdk-9_1.0_all.deb /

RUN \
    dpkg -i to-jdk-9_1.0_all.deb && \
    rm to-jdk-9_1.0_all.deb

# quick cheat to save some build time
RUN \
    apt-get install -y maven-debian-helper

COPY build.sh /
