#!/bin/bash
set -eu
P=$1

msg() {
    echo
    echo
    echo '#######################################################'
    echo '##' "$(date -uIseconds)" '##' "$@"
    echo '#######################################################'
    echo
}

msg Building ${P}
mkdir -p /build
cd /build


msg System state
apt list --installed


msg Download source
apt-get source ${P}
cd ${P}-*


msg Build dependencies
apt-get build-dep -y .


msg Build
dpkg-buildpackage -us -uc -b


msg Done
