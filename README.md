faux@astoria:~/code/fbuilder/dose-parse% P=$(<ordered-deps unyaml | fgrep default-jdk | cut -d: -f 1 | sed 's/$/.pkg/')
make -j8 ${=P}

