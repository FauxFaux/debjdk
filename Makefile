all: base.img

base.img: base/Dockerfile base/apt.conf base/build.sh base/sources.list \
		base/to-jdk-9_1.0_all.deb base/libmaven-javadoc-plugin-java_2.10.4-2_all.deb \
        base/openjdk-9-jdk-headless_9~b181-2_amd64.deb \
        base/openjdk-9-jdk_9~b181-2_amd64.deb \
        base/openjdk-9-jre-headless_9~b181-2_amd64.deb \
        base/openjdk-9-jre_9~b181-2_amd64.deb

	# actually do the build
	docker build base

	# capture the id
	docker build -q base > base.img

base/to-jdk-9_1.0_all.deb: base/to-jdk-9.equivs
	cd base && equivs-build ../$^

base/openjdk-9-%.deb: jdk/Dockerfile
	# actually show the progress
	docker build jdk

	# extract the artfiacts
	docker cp $(shell docker run -d $(shell docker build -q jdk) true):/$(@F) $@


run:
	docker run -it $(shell cat base.img) /bin/bash

clean:
	$(RM) base.img base/to-jdk-9_1.0_all.deb

deps:
	apt-get install equivs

%.pkg: base.img
	docker run $(shell cat base.img) bash /build.sh $* > $@.wip 2>&1 || mv $@.wip $@.fail
	-mv $@.wip $@
