.PHONY: all clean upload dist

PWD=$(shell pwd)
# Should be built there
LIQ_DIR=$(PWD)/../liquidsoap
LIQI=$(LIQ_DIR)/doc/liqi/liqi
LIQUIDSOAP=$(LIQ_DIR)/src/liquidsoap

# Versions documented.
VERSIONS=svn 0.3.8 0.9.0 0.9.1 0.9.2 1.0.0-beta1

# Static content
content_expand = $(wildcard $(PWD)/content/doc-$(version)/*.txt)
content_expanded = $(foreach version,$(VERSIONS),$(content_expand))
CONTENT=$(wildcard $(PWD)/content/*.txt) $(content_expanded)
HTML=$(shell echo $(CONTENT:.txt=.html) | sed -e 's/content\//html\//g')

# Generated content
GENERATED_FILES=$(PWD)/html/doc-@@VERSION@@/reference.html \
                $(PWD)/html/doc-@@VERSION@@/scripts/index.html \
                $(PWD)/html/doc-@@VERSION@@/settings.html
generated_files_subst = $(subst @@VERSION@@,$(version),$(GENERATED_FILES))
generated_files = $(foreach version,$(VERSIONS),$(generated_files_subst))

all: $(HTML) $(generated_files)
	@find html -name '.svn' -exec rm -rf \{\} \; || true

# Removes all unecessary stuff before upload
dist: all
	@find html -name '*.txt' -exec rm -f \{\} \; || true

$(LIQI):
	@echo "Liqi parser does not seem to be built..."
	@exit 1

$(LIQUIDSOAP):
	@echo "Liquidsoap does not seem to be built..."
	@exit 1

$(PWD)/html/index.html: $(PWD)/content/index.txt $(LIQI)
	@echo Converting $(<) to $(@)...
	@test -d html || (mkdir -p html/scripts ; cp -rf orig/* html)
	@cd $(PWD)/html && $(LIQI) --main-main -i $(<) -o $(@) --basedir $(PWD)/html

$(PWD)/html/doc-%/reference.txt:
	@cp $(PWD)/reference-$(*).txt $(PWD)/html/doc-$(*)/reference.txt

$(PWD)/html/doc-%/settings.txt:
	@cp $(PWD)/settings-$(*).txt $(PWD)/html/doc-$(*)/settings.txt

$(PWD)/html/doc-svn/reference.txt: $(LIQUIDSOAP)
	@echo "Generating svn language reference..."
	@echo "Did you enable all features ?"
	@$(LIQUIDSOAP) --no-pervasives $(LIQ_DIR)/scripts/utils.liq --list-plugins-xml | \
	$(LIQ_DIR)/doc/reference_to_liqi.pl > $(PWD)/html/doc-svn/reference.txt	

$(PWD)/html/doc-svn/settings.txt: $(LIQUIDSOAP)
	@echo "Generating svn language settings..."
	@echo "Did you enable all features ?"
	@$(LIQUIDSOAP) --no-pervasives $(LIQ_DIR)/scripts/utils.liq --conf-descr | \
	$(LIQ_DIR)/doc/settings_to_liqi.pl > $(PWD)/html/doc-svn/settings.txt

$(PWD)/html/doc-%/reference.html: $(PWD)/html/doc-%/reference.txt
	@cd html/doc-$(*) && $(LIQI) --main -i $(<) -o $(@) --basedir $(PWD)/html

$(PWD)/html/doc-%/settings.html: $(PWD)/html/doc-%/settings.txt
	@cd html/doc-$(*) && $(LIQI) --main -i $(<) -o $(@) --basedir $(PWD)/html

$(PWD)/html/doc-%/scripts/index.html:
	@cd $(shell dirname $(@)) && \
          if [ "$(shell basename $(shell dirname $(@)))" != "html" ]; then \
          mkdir -p scripts; fi && \
          $(LIQI) --main -i $(shell dirname $(@))/index.txt -o $(@) --basedir $(PWD)/html		

$(PWD)/html/%.html: $(PWD)/content/%.txt $(LIQI)
	@echo Converting $(<) to $(@)...
	@test -d html || (mkdir html ; cp -rf orig/* html)
	@test -d $(shell dirname $(@)) || (mkdir -p $(shell dirname $(@)))
	@#Has to be called from html to put scripts in the right place
	@cd $(shell dirname $(@)) && \
	  if [ "$(shell basename $(shell dirname $(@)))" != "html" ]; then \
	  mkdir -p scripts; fi && \
	  $(LIQI) --main -i $(<) -o $(@) --basedir $(PWD)/html

clean:
	rm -rf html

RCP=rsync -rLtCPz --exclude="*.swp" --exclude="*.svn" \
	--delete --stats
RHOST=$(USER),savonet@web.sourceforge.net:/home/groups/s/sa/savonet/htdocs

upload: dist
	cd html ; $(RCP) . $(RHOST) || true
