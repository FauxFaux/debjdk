FROM sid-be:latest

RUN \
    apt-get install -y default-jdk maven-debian-helper && \
    apt-get clean

RUN \
    apt-get source guice && \
    cd guice-* && \
    apt-get build-dep -y . && \
    dpkg-buildpackage -us -uc -b
