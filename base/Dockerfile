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
COPY libmaven-javadoc-plugin-java_2.10.4-2_all.deb /

RUN \
    apt-get install -y libmaven-javadoc-plugin-java && \
    dpkg -i to-jdk-9_1.0_all.deb libmaven-javadoc-plugin-java_2.10.4-2_all.deb && \
    rm *.deb && \
    apt-get clean

# quick cheat to save some build time
RUN \
    apt-get install -y cdbs devscripts javahelper junit4 maven-debian-helper && \
    apt-get clean

# build.sh dependencies
RUN \
    apt-get install -y bash eatmydata && \
    apt-get clean

COPY build.sh /
