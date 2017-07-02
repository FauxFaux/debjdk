#!/bin/bash

rm understood
paste <(

printf " Success\n=========\n%s total\n" $(ls -1 *.pkg | wc -l)

) <(

echo ASCII
echo =====
fgrep -l 'encoding US-ASCII' *.fail | sed 's/.pkg.fail$//' | tee -a understood

) <(

echo javadoc
echo =======
egrep -l ': Unable to find javadoc command.*JAVA_HOME' *.fail | sed 's/.pkg.fail$//' | tee -a understood

) <(

echo doclint
echo =======

egrep -l 'error: bad use of|error: @param |error: block element not|error: unexpected content|error: no summary or|error: end tag|error: self-closing' *.fail | sed 's/.pkg.fail$//' | tee -a understood

) <(

echo identifier
echo ==========

fgrep -l 'is a keyword, and may not be used as an identifier' *.fail | sed 's/.pkg.fail$//' | tee -a understood

) <(

echo version
echo =======

fgrep -l 'Source option 1.' *.fail | sed 's/.pkg.fail$//' | tee -a understood

) <(

echo modules
echo =======

fgrep -l 'reflect.InaccessibleObjectException' *.fail | sed 's/.pkg.fail$//' | tee -a understood

) >first

paste first <(

echo unknown
echo =======
diff -u <(<understood sort -u) <(ls -1 *.fail | sed 's/.pkg.fail$//') | grep '^+' | cut -c2- | sed 1d

)| column -nt -s $'\t'

