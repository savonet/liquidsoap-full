.PHONY: all serve clean upload actual-upload dist

PWD := $(shell pwd)
LIQ_DIR := $(PWD)/../liquidsoap
LIQUIDSOAP := $(LIQ_DIR)/src/liquidsoap
OCAMLDOC := ocamldoc
PANDOC := pandoc --syntax-definition=liquidsoap.xml --highlight=pygments
NODE := $(shell which node)

# Versions for which documentation should be built and included
VERSIONS := dev 1.3.0 1.3.1 1.3.2 1.3.3 1.3.4 1.3.5 1.3.6 1.3.7
DEFAULT_VERSION := 1.3.7
# DEFAULT_VERSION := dev

# Static content
images_expand = $(wildcard $(PWD)/content/doc-$(version)/images/*)
images_expanded := $(foreach version,$(VERSIONS),$(images_expand))

content_expand = $(wildcard $(PWD)/content/doc-$(version)/*.md)
content_expanded := $(foreach version,$(VERSIONS),$(content_expand))
content_website := $(wildcard $(PWD)/content/*.md)
CONTENT := $(content_website) $(content_expanded) $(images_expanded)

JS := $(shell echo $(wildcard $(PWD)/orig/assets/js/*.js) | sed -e 's|/orig/|/html/|g')
HTML := $(shell echo $(CONTENT:.md=.html) | sed -e 's|/content/|/html/|'g)

$(PWD)/html/assets/js/%.js: orig/assets/js/%.js
# ifneq ($(NODE),)
#	@echo Uglifying $(@)
#	@node scripts/uglify.js < $(<) > $(@)
# else
	@cp $(<) $(@)
#endif

# Generated content
GENERATED_FILES := $(PWD)/html/doc.html $(PWD)/html/doc-@@VERSION@@/reference.html \
                   $(PWD)/html/doc-@@VERSION@@/protocols.html \
                   $(PWD)/html/doc-@@VERSION@@/settings.html
generated_files_subst = $(subst @@VERSION@@,$(version),$(GENERATED_FILES))
generated_files := $(foreach version,$(VERSIONS),$(generated_files_subst)) $(PWD)/html/modules.html $(PWD)/html/modules/liquidsoap

all: language.dtd $(PWD)/html $(HTML) $(JS) $(generated_files)
	@find html -name '.git' | xargs rm -rf --

MODULES_INC := $(wildcard $(PWD)/../ocaml-*/src)

$(PWD)/html/doc.html: $(PWD)/doc.html
	sed -e "s#@version@#$(DEFAULT_VERSION)#" < $(<) > $(@) 

$(PWD)/html/modules.md: $(PWD)/html $(PWD)/../PACKAGES.default
	echo "## Savonet modules documentation\n" > $(@)
	cat $(PWD)/../PACKAGES.default | grep '^ocaml' | sort | while read i; do \
	  echo "* [$$i](modules/$$i/index.html)" >> $(@) ; \
	  mkdir -p $(PWD)/html/modules/$$i; \
	  $(OCAMLDOC) -html -stars -d $(PWD)/html/modules/$$i $(MODULES_INC:%=-I %) $(PWD)/../$$i/src/*.mli; \
	done

$(PWD)/html/modules.html: $(PWD)/html/modules.md
	$(PANDOC) --template template.html --metadata pagetitle=Modules -i $< -o $@

$(PWD)/html/modules/liquidsoap: $(PWD)/html
	@$(MAKE) -C $(LIQ_DIR) doc
	cp -r $(LIQ_DIR)/autodoc/liquidsoap $(PWD)/html/modules/

# Removes all unecessary stuff before upload
dist: all
	@find $(PWD)/html -name '*.md' | xargs rm -rf --
	rm -rf savonet.github.io
	git clone git@github.com:savonet/savonet.github.io.git
	find savonet.github.io -mindepth 1 | grep -v 'savonet.github.io/.git' | xargs rm -rf
	cp -rf html/* savonet.github.io

$(PWD)/html: $(wildcard orig/*)
	@mkdir -p $(PWD)/html/scripts
	@cp -r $(PWD)/orig/* $(PWD)/html
	@cp -r $(PWD)/orig/CNAME $(PWD)/html
	@rm -f $(PWD)/html/js/*.js

$(LIQUIDSOAP):
	@echo "Liquidsoap does not seem to be built..."
	@exit 1

# Auto-generated content files

$(PWD)/html/doc-dev/reference.md: $(LIQUIDSOAP) $(PWD)/reference-header.md
	@echo "Generating dev language reference..."
	@echo "Did you enable all features ?"
	cat $(PWD)/reference-header.md > $(PWD)/reference.md
	$(LIQUIDSOAP) --no-pervasives $(LIQ_DIR)/libs/pervasives.liq --list-functions-md >> $(PWD)/reference.md
	cp $(PWD)/reference.md $@

$(PWD)/html/doc-dev/settings.md: $(LIQUIDSOAP)
	@echo "Generating dev language settings..."
	@echo "Did you enable all features ?"
	@$(LIQUIDSOAP) --no-pervasives $(LIQ_DIR)/libs/pervasives.liq --conf-descr-md | grep -v "# Liquidsoap configuration" > $@

$(PWD)/html/doc-dev/protocols.md: $(LIQUIDSOAP)
	@echo "Generating dev protocols reference..."
	@echo "Did you enable all features ?"
	@$(LIQUIDSOAP) --no-pervasives $(LIQ_DIR)/libs/pervasives.liq --list-protocols-md > $(PWD)/protocols.md
	cp $(PWD)/protocols.md $@

# We copy ref and settings to the git:external directories where they belong

$(PWD)/html/doc-%/reference.md: $(PWD)/reference-%.md
	@cp $(PWD)/reference-$(*).md $(PWD)/html/doc-$(*)/reference.md

$(PWD)/html/doc-%/settings.md: $(PWD)/settings-%.md
	@cp $(PWD)/settings-$(*).md $(PWD)/html/doc-$(*)/settings.md

$(PWD)/html/doc-%/protocols.md:
	@([ -f $(PWD)/protocols-$(*).md ] && cp $(PWD)/protocols-$(*).md $(PWD)/html/doc-$(*)/protocols.md) || \
	  cp $(LIQ_DIR)/doc/no-proto.md $(PWD)/html/doc-$(*)/protocols.md

$(PWD)/html/index.html: $(PWD)/content/index.md
	@echo Converting $(<) to $(@)...
	@$(PANDOC) --template template.html --metadata version=$(DEFAULT_VERSION) --metadata versions="$(VERSIONS)" --metadata pagetitle=Index -i $< -o $@

$(PWD)/html/doc-%/reference.html: $(PWD)/html/doc-%/reference.md template.html
	@$(PANDOC) --template template.html --metadata version=$(firstword $(subst /, ,$(*))) --metadata versions="$(VERSIONS)" --metadata pagetitle=Reference -i $< -o $@

$(PWD)/html/doc-%/settings.html: $(PWD)/html/doc-%/settings.md template.html
	@$(PANDOC) --toc --template template.html --metadata version=$(firstword $(subst /, ,$(*))) --metadata versions="$(VERSIONS)" --metadata pagetitle=Settings -i $< -o $@

$(PWD)/html/doc-%/protocols.html: $(PWD)/html/doc-%/protocols.md template.html
	@$(PANDOC) --template template.html --metadata version=$(firstword $(subst /, ,$(*))) --metadata versions="$(VERSIONS)" --metadata pagetitle=Protocols -i $< -o $@

$(PWD)/html/doc-%.html: $(PWD)/content/doc-%.md $(PWD)/template.html
	@echo Converting $(<) to $(@)...
	@test -d $(shell dirname $(@)) || (mkdir -p $(shell dirname $(@)))
	@$(PANDOC) --template template.html --metadata version=$(firstword $(subst /, ,$(*))) --metadata versions="$(VERSIONS)" --metadata pagetitle="$(basename $(notdir $@))" -i $< -o $@

define IMAGE_RULE
$(PWD)/html/doc-$(version)/images/%: $(PWD)/content/doc-$(version)/images/%
	@echo "$$(<) -> $$(@)"
	@mkdir -p $$(shell dirname $$(@))
	@cp -rf $$(<) $$(@)
endef
$(foreach version,$(VERSIONS),$(eval $(IMAGE_RULE)))

clean:
	rm -rf savonet.github.io html

actual-upload: dist
	cd savonet.github.io && git add . && \
	git commit -m"Update website." && git push

upload: Dockerfile
	@echo "Make sure that you have comitted and pushed your changes!"
	docker pull savonet/liquidsoap-full
	tar cvzf - Dockerfile -C $${HOME} .ssh .gitconfig | docker build -t savonet/website --no-cache -

serve:
	cd html && python -m SimpleHTTPServer

language.dtd:
	curl https://raw.githubusercontent.com/jgm/highlighting-kate/master/xml/language.dtd -o $@
