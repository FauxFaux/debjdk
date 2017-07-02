#!/bin/bash

count() {
    sed 's/\.pkg\.fail$//; s/\.pkg$//' > .${1}.lst
}

ls -1 *.pkg | count success

fgrep -l 'encoding US-ASCII' *.fail | count ascii

egrep -l ': Unable to find javadoc command.*JAVA_HOME' *.fail | count javadoc

egrep -l 'error: bad use of|error: @param |error: block element not|error: unexpected content|error: no summary or|error: end tag|error: self-closing|error: bad HTML|error: unexpected end' *.fail \
    | count doclint

fgrep -l 'is a keyword, and may not be used as an identifier' *.fail | count keyword

egrep -l 'Source option 1\.|-source 1\.[1-5] -target 1\.[1-5]|requires target release 1\.' *.fail | count version

egrep -l 'reflect\.InaccessibleObjectException|reference to Module is ambigu|is not visible|because module .* does not export|location: package sun\.misc' *.fail | count modules

egrep -l 'not resolve dependencies for project|Problem parsing dependency: Build-Depends-Indep|Non-resolvable parent POM for' *.fail | count deps

egrep -l 'error: incompatible types:' *.fail | count cast

fgrep -l 'There are test failures.' *.fail | count tests

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

