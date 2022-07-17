.PHONY: all serve clean upload actual-upload dist

PWD := $(shell pwd)
GENERATED_DOC_DIR := $(PWD)/../liquidsoap/_build/default/doc
GENERATED_INTERPRETER_DIR := $(PWD)/../liquidsoap/_build/default/src/js
PANDOC := pandoc --syntax-definition=liquidsoap.xml --highlight=pygments
NODE := $(shell which node)

# Versions for which documentation should be built and included
VERSIONS := dev 1.4.0 1.4.1 1.4.2 1.4.3 1.4.4 2.0.0 2.0.1 2.0.2 2.0.3 2.0.4 2.0.5 2.0.6 2.0.7 2.1.0
DEFAULT_VERSION := 2.1.0
# DEFAULT_VERSION := dev

# Static content
images_expand = $(wildcard $(PWD)/content/doc-$(version)/images/*)
images_expanded := $(foreach version,$(VERSIONS),$(images_expand))

content_expand = $(wildcard $(PWD)/content/doc-$(version)/*.md)
content_expanded := $(foreach version,$(VERSIONS),$(content_expand))
content_website := $(wildcard $(PWD)/content/*.md)
CONTENT := $(content_website) $(content_expanded) $(images_expanded)

JS := $(shell echo $(wildcard $(PWD)/orig/assets/js/*.js) | sed -e 's|/orig/|/html/|g')
HTML := $(shell echo $(CONTENT:.md=.html) | sed -e 's|/content/|/html/|'g) $(PWD)/html/try

$(PWD)/html/assets/js/%.js: orig/assets/js/%.js
# ifneq ($(NODE),)
#	@echo Uglifying $(@)
#	@node scripts/uglify.js < $(<) > $(@)
# else
	@cp $(<) $(@)
#endif

# Generated content
GENERATED_FILES := $(PWD)/html/doc.html \
                   $(PWD)/html/doc-@@VERSION@@/reference.html \
                   $(PWD)/html/doc-@@VERSION@@/reference-extras.html \
                   $(PWD)/html/doc-@@VERSION@@/protocols.html \
                   $(PWD)/html/doc-@@VERSION@@/settings.html
generated_files_subst = $(subst @@VERSION@@,$(version),$(GENERATED_FILES))
generated_files := $(foreach version,$(VERSIONS),$(generated_files_subst))

all: language.dtd $(PWD)/html $(HTML) $(JS) $(generated_files)
	@find html -name '.git' | xargs rm -rf --

MODULES_INC := $(wildcard $(PWD)/../ocaml-*/src)

$(PWD)/html/doc.html: $(PWD)/doc.html
	sed -e "s#@version@#$(DEFAULT_VERSION)#" < $(<) > $(@) 

# Removes all unecessary stuff before upload
dist: all
	@find $(PWD)/html -name '*.md' | xargs rm -rf --

$(PWD)/html: $(wildcard orig/*)
	@mkdir -p $(PWD)/html/scripts
	@cp -r $(PWD)/orig/* $(PWD)/html
	@cp -r $(PWD)/orig/CNAME $(PWD)/html
	@rm -f $(PWD)/html/js/*.js

# Auto-generated content files

$(PWD)/content/doc-dev/reference.md $(PWD)/content/doc-dev/reference-extras.md $(PWD)/content/doc-dev/settings.md $(PWD)/content/doc-dev/protocols.md:
	@cp $(GENERATED_DOC_DIR)/$(shell basename $@) $@ 

# JS interpreter
$(PWD)/html/try: $(GENERATED_INTERPRETER_DIR) 
	@mkdir -p $@
	@cp -rf $(GENERATED_INTERPRETER_DIR)/liquidsoap_js.bc.js $@
	@cp -rf $(GENERATED_INTERPRETER_DIR)/index.html $@

define VERSIONED_RULES
$(PWD)/html/doc-$(version)/%.html: $(PWD)/content/doc-$(version)/%.md $(PWD)/template-$(version).html
	@echo Converting $$(<) to $$(@)...
	@test -d $$(shell dirname $$(@)) || (mkdir -p $$(shell dirname $$(@)))
	@$(PANDOC) --template template-$(version).html --metadata version=$(version) --metadata versions="$(VERSIONS)" --metadata pagetitle="$$(basename $$(notdir $$@))" -i $$< -o $$@

$(PWD)/html/doc-$(version)/images/%: $(PWD)/content/doc-$(version)/images/%
	@echo "$$(<) -> $$(@)"
	@mkdir -p $$(shell dirname $$(@))
	@cp -rf $$(<) $$(@)
endef
$(foreach version,$(VERSIONS),$(eval $(VERSIONED_RULES)))

clean:
	rm -rf savonet.github.io html

actual-upload: dist
	rm -rf savonet.github.io
	git clone git@github.com:savonet/savonet.github.io.git
	find savonet.github.io -mindepth 1 | grep -v 'savonet.github.io/.git' | xargs rm -rf
	cp -rf html/* savonet.github.io
	cp content/doc-dev/reference.md savonet.github.io/reference.md
	cd savonet.github.io && git add . && \
	git commit -m"Update website." && git push

upload: Dockerfile
	@echo "Make sure that you have comitted and pushed your changes!"
	docker pull savonet/liquidsoap-full:debian_testing
	tar cvzf - Dockerfile -C $${HOME} .ssh .gitconfig | docker build -t savonet/website --no-cache -

serve:
	cd html && python3 -m http.server

language.dtd:
	curl https://raw.githubusercontent.com/jgm/highlighting-kate/master/xml/language.dtd -o $@
