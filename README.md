```
faux@astoria:~/code/fbuilder/dose-parse% P=$(<ordered-deps unyaml | fgrep default-jdk | cut -d: -f 1 | sed 's/$/.pkg/')
make -j8 ${=P}
bzcat reproducible.json.bz2 | jq -r '.[]|select(.architecture=="amd64" and .status != "reproducible" and .status != "unreproducible" and .suite=="unstable")|.package'  > .jenkins
```
