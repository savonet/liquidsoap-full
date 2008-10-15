PRJ=`cat PACKAGES | grep -v '^\#'`

default: all

all:
	for i in $(PRJ); do $(MAKE) -C $$i || exit 1; done

clean:
	for i in $(PRJ); do $(MAKE) -C $$i $@; done

doc:
	$(MAKE) -C liquidsoap doc

install:
	$(MAKE) -C liquidsoap install

changelog:
	@rm -f ChangeLog
	@svn log > ChangeLog
