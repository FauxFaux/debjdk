all: base.img

base.img: Dockerfile apt.conf build.sh sources.list to-jdk-9_1.0_all.deb
	# actually do the build
	docker build .

	# capture the id
	docker build -q . > base.img

to-jdk-9_1.0_all.deb: to-jdk-9.equivs
	equivs-build $^

clean:
	$(RM) base.img to-jdk-9_1.0_all.deb

deps:
	apt-get install equivs
