.PHONY: all serve clean upload atual-upload dist

PWD := $(shell pwd)
# Should be built there
LIQ_DIR := $(PWD)/../liquidsoap
LIQI := $(LIQ_DIR)/doc/liqi/liqi
LIQUIDSOAP := $(LIQ_DIR)/src/liquidsoap
OCAMLDOC := ocamldoc


# Versions for which documentation should be build and included
VERSIONS := dev 1.3.0 1.3.1 1.3.2 1.3.3 1.3.4
DEFAULT_VERSION := 1.3.4

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
		               $(PWD)/html/doc-@@VERSION@@/protocols.html \
                   $(PWD)/html/doc-@@VERSION@@/scripts/index.html \
                   $(PWD)/html/doc-@@VERSION@@/settings.html
generated_files_subst = $(subst @@VERSION@@,$(version),$(GENERATED_FILES))
generated_files := $(foreach version,$(VERSIONS),$(generated_files_subst)) $(PWD)/html/modules.html $(PWD)/html/modules/liquidsoap

all: $(PWD)/html $(HTML) $(JS) rss $(generated_files)
	@find html -name '.git' | xargs rm -rf --

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
	    --template ../template.html \
	    -i $(<) -o $(@)

$(PWD)/html/modules/liquidsoap: $(PWD)/html
	@$(MAKE) -C $(LIQ_DIR) doc
	cp -r $(LIQ_DIR)/autodoc/liquidsoap $(PWD)/html/modules/

# Removes all unecessary stuff before upload
dist: all
	@find $(PWD)/html -name '*.txt' | xargs rm -rf --
	rm -rf savonet.github.io
	git clone git@github.com:savonet/savonet.github.io.git
	find savonet.github.io -mindepth 1 | grep -v 'savonet.github.io/.git' | xargs rm -rf
	cp -rf html/* savonet.github.io

$(PWD)/html: $(wildcard orig/*)
	@mkdir -p $(PWD)/html/scripts
	@cp -r $(PWD)/orig/* $(PWD)/html
	@cp -r $(PWD)/orig/CNAME $(PWD)/html
	@rm -f $(PWD)/html/js/*.js

$(LIQI):
	@echo "Liqi parser does not seem to be built..."
	@exit 1

$(LIQUIDSOAP):
	@echo "Liquidsoap does not seem to be built..."
	@exit 1

# Auto-generated content files

$(PWD)/html/doc-dev/reference.txt: $(LIQUIDSOAP)
	@echo "Generating dev language reference..."
	@echo "Did you enable all features ?"
	@($(LIQUIDSOAP) --no-pervasives \
	  $(LIQ_DIR)/scripts/pervasives.liq --list-plugins-xml | \
	$(LIQ_DIR)/doc/reference_to_liqi.pl || cat $(LIQ_DIR)/doc/no-ref.txt) > $(PWD)/reference.txt
	cp $(PWD)/reference.txt $(PWD)/html/doc-dev/reference.txt

$(PWD)/html/doc-dev/settings.txt: $(LIQUIDSOAP)
	@echo "Generating dev language settings..."
	@echo "Did you enable all features ?"
	@$(LIQUIDSOAP) --no-pervasives $(LIQ_DIR)/scripts/pervasives.liq --conf-descr-liqi > $(PWD)/html/doc-dev/settings.txt

$(PWD)/html/doc-dev/protocols.txt: $(LIQUIDSOAP)
	@echo "Generating dev protocols reference..."
	@echo "Did you enable all features ?"
	@($(LIQUIDSOAP) --no-pervasives \
	  $(LIQ_DIR)/scripts/pervasives.liq --list-plugins-xml | \
	$(LIQ_DIR)/doc/protocols_to_liqi.pl || cat $(LIQ_DIR)/doc/no-proto.txt) > $(PWD)/protocols.txt
	cp $(PWD)/protocols.txt $(PWD)/html/doc-dev/protocols.txt

# We copy ref and settings to the git:external directories where they belong

$(PWD)/html/doc-%/reference.txt:
	@cp $(PWD)/reference-$(*).txt $(PWD)/html/doc-$(*)/reference.txt

$(PWD)/html/doc-%/settings.txt:
	@cp $(PWD)/settings-$(*).txt $(PWD)/html/doc-$(*)/settings.txt

$(PWD)/html/doc-%/protocols.txt:
	@([ -f $(PWD)/protocols-$(*).txt ] && cp $(PWD)/protocols-$(*).txt $(PWD)/html/doc-$(*)/protocols.txt) || \
	  cp $(LIQ_DIR)/doc/no-proto.txt $(PWD)/html/doc-$(*)/protocols.txt

# HTML generation
#$(PWD)/html/_index.html: savonet.html
$(PWD)/html/_index.html: savonet.html html/_news.html
	@cat savonet.html \
	| sed '/<!-- NEWS -->/r html/_news.html' \
	> $@

$(PWD)/html/index.html: $(PWD)/content/index.txt $(LIQI) $(PWD)/html/_index.html snippet.html
	@echo Converting $(<) to $(@)...
	@cd $(PWD)/html && $(LIQI) \
		--subst version:$(DEFAULT_VERSION) --subst versions:"$(VERSIONS)" \
	  --template $(PWD)/html/_index.html --snippet-template ../snippet.html \
	  -i $(<) -o $(@)

$(PWD)/html/doc-%/reference.html: $(PWD)/html/doc-%/reference.txt template.html snippet.html
	@cd html/doc-$(*) && $(LIQI) \
	  --template ../../template.html --snippet-template ../../snippet.html \
	  --subst version:$(*) --subst versions:"$(VERSIONS)" --basedir .. \
	  -i $(<) -o $(@)

$(PWD)/html/doc-%/settings.html: $(PWD)/html/doc-%/settings.txt template.html snippet.html
	@cd html/doc-$(*) && $(LIQI) \
	  --template ../../template.html --snippet-template ../../snippet.html \
	  --subst version:$(*) --subst versions:"$(VERSIONS)" --basedir .. \
	  -i $(<) -o $(@)

$(PWD)/html/doc-%/protocols.html: $(PWD)/html/doc-%/protocols.txt template.html snippet.html
	@cd html/doc-$(*) && $(LIQI) \
	  --template ../../template.html --snippet-template ../../snippet.html \
	  --subst version:$(*) --subst versions:"$(VERSIONS)" --basedir .. \
	  -i $(<) -o $(@)

$(PWD)/html/doc-%/scripts/index.html: $(PWD)/template.html
	@echo Generating script index for $(*)
	@cd $(shell dirname $(@)) && \
          if [ "$(shell basename $(shell dirname $(@)))" != "html" ]; then \
          mkdir -p scripts; fi && \
          $(LIQI) \
		    --template ../../../template.html \
			--subst rel:../ --subst version:$(*) --subst versions:"$(VERSIONS)" --basedir ../.. \
		    -i $(shell dirname $(@))/index.txt -o $(@)

$(PWD)/html/doc-%.html: $(PWD)/content/doc-%.txt $(LIQI) $(PWD)/template.html $(PWD)/snippet.html
	@echo Converting $(<) to $(@)...
	@test -d $(shell dirname $(@)) || (mkdir -p $(shell dirname $(@)))
	@#Has to be called from html/doc-VERSION to put scripts in the right place
	@cd html/`dirname doc-$(*)` && \
	  if [ "$(shell basename $(shell dirname $(@)))" != "html" ]; then \
	  mkdir -p scripts; fi && \
	  $(LIQI) \
	    --template ../../template.html --snippet-template ../../snippet.html \
		--subst version:`dirname $(*)` --subst versions:"$(VERSIONS)" --basedir .. \
	    -i $(<) -o $(@)

spell-check: $(content_website:.txt=.txt.spell)

$(PWD)/content/%.txt.spell: content/%.txt
	-aspell -d en_US-w_accents -c $(<)
	touch $(@)

clean:
	rm -rf savonet.github.io html content/*.txt.spell

actual-upload: dist
	cd savonet.github.io && git add . && \
	git commit -m"Update website." && git push

upload: Dockerfile
	@echo "Make sure that you have comitted and pushed your changes!"
	tar cvzf - Dockerfile -C $${HOME} .ssh .gitconfig | sudo docker build -t savonet/website --no-cache -

rss: $(PWD)/html/liquidsoap.rss

DATE := $(shell date -R 2>/dev/null || date)

$(PWD)/html/liquidsoap.rss: news.txt
	@echo Generating $@
	@echo '<?xml version="1.0" encoding="UTF-8" ?>\n<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">' > $@
	@echo '<channel>' >> $@
	@echo '<title>Liquidsoap: news</title>' >> $@
	@echo '<description>savonet.sf.net</description>' >> $@
	@echo '<atom:link href="http://liquidsoap.info/liquidsoap.rss" rel="self" type="application/rss+xml" />' >> $@
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

serve:
	cd html && python -m SimpleHTTPServer
