PRJ:=$(shell cat PACKAGES | grep -v '^\#')
PRJ:=$(shell for p in $(PRJ) ; do ls -d $$p* | head -1 ; done)
LIQ:=$(shell ls -d liquidsoap* | head -1)

default: all

all:
	for i in $(PRJ); do $(MAKE) -C $$i || exit 1; done

clean:
	for i in $(PRJ); do $(MAKE) -C $$i $@; done

doc:
	$(MAKE) -C $(LIQ) doc

install:
	$(MAKE) -C $(LIQ) install
