%.pkg:
	$(MAKE) -C base
	docker run $(shell cat base/base.img) bash /build.sh $* > $@ 2>&1
