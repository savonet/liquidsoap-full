.PHONY: all clean upload dist

PWD := $(shell pwd)
# Should be built there
LIQ_DIR := $(PWD)/../liquidsoap
LIQI := $(LIQ_DIR)/doc/liqi/liqi
LIQUIDSOAP := $(LIQ_DIR)/src/liquidsoap
OCAMLDOC := ocamldoc.opt


# Versions for which documentation should be build and included
VERSIONS := svn 0.9.2 1.0.0 1.0.1 1.1.0 1.1.1

# Static content
content_expand = $(wildcard $(PWD)/content/doc-$(version)/*.txt)
content_expanded := $(foreach version,$(VERSIONS),$(content_expand))
content_website := $(wildcard $(PWD)/content/*.txt)
CONTENT := $(content_website) $(content_expanded)

JS := $(shell echo $(wildcard $(PWD)/orig/js/*.js) | sed -e 's|/orig/|/html/|g')
HTML := $(shell echo $(CONTENT:.txt=.html) | sed -e 's|/content/|/html/|'g)

NODE := $(shell which node)

$(PWD)/html/js/%.js: orig/js/%.js
ifneq ($(NODE),)
	@echo Uglifying $(@)
	@node scripts/uglify.js < $(<) > $(@)
else
	@cp $(<) $(@)
endif

# Generated content
GENERATED_FILES := $(PWD)/html/doc-@@VERSION@@/reference.html \
                   $(PWD)/html/doc-@@VERSION@@/scripts/index.html \
                   $(PWD)/html/doc-@@VERSION@@/settings.html
generated_files_subst = $(subst @@VERSION@@,$(version),$(GENERATED_FILES))
generated_files := $(foreach version,$(VERSIONS),$(generated_files_subst)) $(PWD)/html/modules.html $(PWD)/html/modules/liquidsoap

all: $(PWD)/html $(HTML) $(JS) rss $(generated_files)
	@find html -name '.svn' | xargs rm -rf --

MODULES_INC := $(wildcard $(PWD)/../ocaml-*/src)

$(PWD)/html/modules.txt: $(PWD)/html $(PWD)/../PACKAGES.default
	echo "title: Savonet modules documentation.\n" > $(@)
	echo "h2. Savonet modules documentation\n" >> $(@)
	cat $(PWD)/../PACKAGES.default | grep '^ocaml' | sort | while read i; do \
	  echo "* \"$$i\":modules/$$i/index.html" >> $(@) ; \
	  mkdir -p $(PWD)/html/modules/$$i; \
	  $(OCAMLDOC) -html -stars -d $(PWD)/html/modules/$$i $(MODULES_INC:%=-I %) $(PWD)/../$$i/src/*.mli; \
	done

$(PWD)/html/modules.html: $(PWD)/html/modules.txt $(LIQI)
	@cd html && \
	  $(LIQI) \
	    --template ../main.html \
	    -i $(<) -o $(@)

$(PWD)/html/modules/liquidsoap: $(PWD)/html
	@$(MAKE) -C $(LIQ_DIR) doc
	cp -r $(LIQ_DIR)/autodoc/liquidsoap $(PWD)/html/modules/

# Removes all unecessary stuff before upload
dist: all
	@find $(PWD)/html -name '*.txt' | xargs rm -rf --

$(PWD)/html: $(wildcard orig/*)
	@mkdir -p $(PWD)/html/scripts
	@cp -r $(PWD)/orig/* $(PWD)/html
	@cp -r $(PWD)/orig/.htaccess $(PWD)/html
	@rm -f $(PWD)/html/js/*.js

$(LIQI):
	@echo "Liqi parser does not seem to be built..."
	@exit 1

$(LIQUIDSOAP):
	@echo "Liquidsoap does not seem to be built..."
	@exit 1

# Auto-generated content files

$(PWD)/html/doc-svn/reference.txt: $(LIQUIDSOAP)
	@echo "Generating svn language reference..."
	@echo "Did you enable all features ?"
	@($(LIQUIDSOAP) --no-pervasives \
	  $(LIQ_DIR)/scripts/utils.liq --list-plugins-xml | \
	$(LIQ_DIR)/doc/reference_to_liqi.pl || cat $(LIQ_DIR)/doc/no-ref.txt) > $(PWD)/reference.txt
	cp $(PWD)/reference.txt $(PWD)/html/doc-svn/reference.txt

$(PWD)/html/doc-svn/settings.txt: $(LIQUIDSOAP)
	@echo "Generating svn language settings..."
	@echo "Did you enable all features ?"
	@$(LIQUIDSOAP) --no-pervasives $(LIQ_DIR)/scripts/utils.liq --conf-descr-liqi > $(PWD)/html/doc-svn/settings.txt

# We copy ref and settings to the svn:external directories where they belong

$(PWD)/html/doc-%/reference.txt:
	@cp $(PWD)/reference-$(*).txt $(PWD)/html/doc-$(*)/reference.txt

$(PWD)/html/doc-%/settings.txt:
	@cp $(PWD)/settings-$(*).txt $(PWD)/html/doc-$(*)/settings.txt

# HTML generation
#$(PWD)/html/_index.html: savonet.html
$(PWD)/html/_index.html: savonet.html html/_news.html
	@cat savonet.html \
	| sed '/<!-- NEWS -->/r html/_news.html' \
	> $@

$(PWD)/html/index.html: $(PWD)/content/index.txt $(LIQI) $(PWD)/html/_index.html snippet.html
	@echo Converting $(<) to $(@)...
	@cd $(PWD)/html && $(LIQI) \
	  --template $(PWD)/html/_index.html --snippet-template ../snippet.html \
	  -i $(<) -o $(@)

$(PWD)/html/doc-%/reference.html: $(PWD)/html/doc-%/reference.txt versioned.html snippet.html
	@cd html/doc-$(*) && $(LIQI) \
	  --template ../../versioned.html --snippet-template ../../snippet.html \
	  --subst version:$(*) --basedir .. \
	  -i $(<) -o $(@)

$(PWD)/html/doc-%/settings.html: $(PWD)/html/doc-%/settings.txt versioned.html snippet.html
	@cd html/doc-$(*) && $(LIQI) \
	  --template ../../versioned.html --snippet-template ../../snippet.html \
	  --subst version:$(*) --basedir .. \
	  -i $(<) -o $(@)

$(PWD)/html/doc-%/scripts/index.html: $(PWD)/versioned.html
	@echo Generating script index for $(*)
	@cd $(shell dirname $(@)) && \
          if [ "$(shell basename $(shell dirname $(@)))" != "html" ]; then \
          mkdir -p scripts; fi && \
          $(LIQI) \
		    --template ../../../versioned.html \
			--subst rel:../ --subst version:$(*) --basedir ../.. \
		    -i $(shell dirname $(@))/index.txt -o $(@)

$(PWD)/html/doc-%.html: $(PWD)/content/doc-%.txt $(LIQI) $(PWD)/versioned.html $(PWD)/snippet.html
	@echo Converting $(<) to $(@)...
	@test -d $(shell dirname $(@)) || (mkdir -p $(shell dirname $(@)))
	@#Has to be called from html/doc-VERSION to put scripts in the right place
	@cd html/`dirname doc-$(*)` && \
	  if [ "$(shell basename $(shell dirname $(@)))" != "html" ]; then \
	  mkdir -p scripts; fi && \
	  $(LIQI) \
	    --template ../../versioned.html --snippet-template ../../snippet.html \
		--subst version:`dirname $(*)` --basedir .. \
	    -i $(<) -o $(@)

$(PWD)/html/%.html: $(PWD)/content/%.txt $(LIQI) $(PWD)/main.html
	@echo Converting main doc $(<) to $(@)...
	@test -d $(shell dirname $(@)) || (mkdir -p $(shell dirname $(@)))
	@cd html && \
	  $(LIQI) \
	    --template ../main.html \
	    -i $(<) -o $(@)

spell-check: $(content_website:.txt=.txt.spell)

$(PWD)/content/%.txt.spell: content/%.txt
	-aspell -d en_US-w_accents -c $(<)
	touch $(@)

clean:
	rm -rf html content/*.txt.spell

RCP=rsync -rLtCPz --exclude="*.swp" --exclude="*.svn" \
	--delete --stats
RHOST=$(USER),savonet@web.sourceforge.net:/home/groups/s/sa/savonet/htdocs

upload: dist
	cd html ; $(RCP) . $(RHOST) || true

%-upload:
	cd html ; $(RCP) $* $(RHOST)/$(shell dirname $*) || true

rss: $(PWD)/html/liquidsoap.rss

DATE := $(shell date -R 2>/dev/null || date)

$(PWD)/html/liquidsoap.rss: news.txt
	@echo Generating $@
	@echo '<?xml version="1.0" encoding="UTF-8" ?>\n<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">' > $@
	@echo '<channel>' >> $@
	@echo '<title>Liquidsoap: news</title>' >> $@
	@echo '<description>savonet.sf.net</description>' >> $@
	@echo '<atom:link href="http://savonet.sourceforge.net/liquidsoap.rss" rel="self" type="application/rss+xml" />' >> $@
	@echo '<link>http://savonet.sf.net/</link>' >> $@
	@echo -n '<lastBuildDate>' >> $@
	@echo -n `date -R` >> $@
	@echo '</lastBuildDate>' >> $@
	@echo -n '<pubDate>' >> $@
	@echo -n $(DATE) >> $@
	@echo '</pubDate>' >> $@
	@echo '<item>' >> $@
#	@echo '<link>http://savonet.sf.net/</link>' >> $@
	@cat $^ \
	| grep -v '^#' \
	| sed 's|\&|\&amp;|g' | sed 's|<|\&lt;|g' | sed 's|>|\&gt;|g' \
	| sed 's|^\* \(.*\)$$|<title>Liquidsoap: \1</title>|' \
	| sed 's|^- date: \(.*\)$$|<pubDate>\1</pubDate>|' \
	| sed 's|^- link: \(.*\)$$|<link>\1</link>|' \
	| sed 's|^- descr: \(.*\)$$|<description>\n\1\n</description>|' \
	| sed 's|^$$|</item>\n<item>|' \
	>> $@
	@echo '</item>' >> $@
	@echo '</channel>' >> $@
	@echo '</rss>' >> $@

html/_news.html: news.txt
	@echo Generating $@
	@echo -n > $@
	@echo '<div class="item">' >> $@
	@cat $^ \
	| grep -v '^#' \
	| head -n 14 \
	| sed 's|^$$|</div>\n<div class="item">|' \
	| sed 's|^\* \(.*\)$$||' \
	| sed 's|^- date: .*\([0-9][0-9] [A-Z][a-z][a-z] [0-9][0-9][0-9][0-9]\).*$$|<div class="title">\1</div>|' \
	| sed 's|^- link: \(.*\)$$||' \
	| sed 's|^- descr: \(.*\)$$|<div class="content">\n\1\n</div>|' \
	>> $@
	@echo '</div>' >> $@
