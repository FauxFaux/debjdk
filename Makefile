all: base.img

base.img: base/Dockerfile base/apt.conf base/build.sh base/sources.list base/to-jdk-9_1.0_all.deb
	# actually do the build
	docker build base

	# capture the id
	docker build -q base > base.img

base/to-jdk-9_1.0_all.deb: base/to-jdk-9.equivs
	cd base && equivs-build $^

clean:
	$(RM) base.img base/to-jdk-9_1.0_all.deb

deps:
	apt-get install equivs

%.pkg: base.img
	docker run $(shell cat base.img) bash /build.sh $* > $@.fail 2>&1
	mv $@.fail $@
