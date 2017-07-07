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

RUN \
    find -name WorkArounds.java -exec grep XMSGS_OPTION {} \;  && \
    find -name WorkArounds.java -exec sed -i 's/doclintOpts.add(DocLint.XMSGS_OPTION);/return;/' {} \; && \
    find -name WorkArounds.java -exec grep XMSGS_OPTION {} \;

RUN \
    dpkg-buildpackage -us -uc -b

