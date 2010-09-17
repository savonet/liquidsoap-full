PRJ:=$(shell cat PACKAGES | grep -v '^\#')
PRJ:=$(shell for p in $(PRJ) ; do ls -d $$p* | head -1 ; done)

default: all

all:
	for i in $(PRJ); do $(MAKE) -C $$i || exit 1; done

clean:
	for i in $(PRJ); do $(MAKE) -C $$i $@; done

doc:
	$(MAKE) -C liquidsoap doc

install:
	$(MAKE) -C liquidsoap install
