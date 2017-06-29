all: base.img

base.img: base/Dockerfile base/apt.conf base/build.sh base/sources.list base/libguice-java_4.0-3_all.deb base/to-jdk-9_1.0_all.deb
	# actually do the build
	docker build base

	# capture the id
	docker build -q base > base.img

base/to-jdk-9_1.0_all.deb: base/to-jdk-9.equivs
	cd base && equivs-build ../$^

base/libguice-java_4.0-3_all.deb: guice/Dockerfile
	# actually show the progress
	docker build guice

	# extract the artfiacts
	docker cp $(shell docker run -d $(shell docker build -q guice) true):/libguice-java_4.0-3_all.deb $@

run:
	docker run -it $(shell cat base.img) /bin/bash

clean:
	$(RM) base.img base/to-jdk-9_1.0_all.deb base/libguice-java_4.0-3_all.deb

deps:
	apt-get install equivs

%.pkg: base.img
	docker run $(shell cat base.img) bash /build.sh $* > $@.wip 2>&1 || mv $@.wip $@.fail
	-mv $@.wip $@
