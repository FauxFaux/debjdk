#!/bin/bash

count() {
    sed 's/\.pkg\.fail$//; s/\.pkg$//' > .${1}.lst
}

ls -1 *.pkg | count success

egrep -l 'error: unmappable character|encoding US-ASCII' *.fail | count encoding

fgrep -l 'Error while generating Javadoc:' *.fail | count javadoc

fgrep -l 'is a keyword, and may not be used as an identifier' *.fail | count keyword

egrep -l 'Source option 1\.|-source 1\.[1-5] -target 1\.[1-5]|requires target release 1\.' *.fail | count version

egrep -l 'reflect\.InaccessibleObjectException|reference to Module is ambigu|is not visible|because module .* does not export|location: package sun\.misc' *.fail | count modules

egrep -l 'not resolve dependencies for project|Problem parsing dependency: Build-Depends-Indep|Non-resolvable parent POM for|Some packages could not be installed. This may mean that you have' *.fail | count deps

egrep -l 'error: incompatible types:' *.fail | count cast

fgrep -l 'There are test failures.' *.fail | count tests

fgrep -l 'cannot find symbol' *.fail | count symbol

fgrep -l 'java.lang.Object in compiler mirror not found' *.fail | count scala

diff -u <(cat .*.lst .jenkins | sort -u) <(ls -1 *.fail | sed 's/.pkg.fail$//' | sort -u) | grep '^+' | cut -c2- | sed 1d > .unknown

rm .success.lst

for f in .*.lst .unknown; do (
    echo ${f} | sed 's/^.//; s/.lst$//'
    echo $(wc -l <${f}) total
    echo '===='
    cat ${f} 
    ) | sed -E 's/(.......)...*(......)/\1*\2/' | sponge ${f}.munged
done

paste .*.munged | column -nt -s $'\t'

