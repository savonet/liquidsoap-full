.PHONY: all clean upload dist

PWD=$(shell pwd)
# Should be built there
LIQ_DIR=$(PWD)/../liquidsoap
LIQI=$(LIQ_DIR)/doc/liqi/liqi
LIQUIDSOAP=$(LIQ_DIR)/src/liquidsoap

# Versions for which documentation should be build and included
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

all: $(HTML) rss $(generated_files)
	@find html -name '.svn' | xargs rm -rf --

# Removes all unecessary stuff before upload
dist: all
	@find html -name '*.txt' | xargs rm -rf --

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
	@$(LIQUIDSOAP) --no-pervasives \
	  $(LIQ_DIR)/scripts/utils.liq --list-plugins-xml | \
	$(LIQ_DIR)/doc/reference_to_liqi.pl > $(PWD)/html/doc-svn/reference.txt

$(PWD)/html/doc-svn/settings.txt: $(LIQUIDSOAP)
	@echo "Generating svn language settings..."
	@echo "Did you enable all features ?"
	@$(LIQUIDSOAP) --no-pervasives $(LIQ_DIR)/scripts/utils.liq --conf-descr | \
	$(LIQ_DIR)/doc/settings_to_liqi.pl > $(PWD)/html/doc-svn/settings.txt

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

$(PWD)/html/index.html: $(PWD)/content/index.txt $(LIQI) $(PWD)/html/_index.html snippet.html $(wildcard orig/*)
	@echo Converting $(<) to $(@)...
	@test -d html || (mkdir -p html/scripts)
	@cp -rf orig/* html
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

$(PWD)/html/doc-%/scripts/index.html: versioned.html
	@echo Generating script index for $(*)
	@cd $(shell dirname $(@)) && \
          if [ "$(shell basename $(shell dirname $(@)))" != "html" ]; then \
          mkdir -p scripts; fi && \
          $(LIQI) \
		    --template ../../../versioned.html \
			--subst rel:../ --subst version:$(*) --basedir ../.. \
		    -i $(shell dirname $(@))/index.txt -o $(@)

$(PWD)/html/doc-%.html: $(PWD)/content/doc-%.txt $(LIQI) versioned.html snippet.html
	@echo Converting $(<) to $(@)...
	@test -d html || (mkdir html ; cp -rf orig/* html)
	@test -d $(shell dirname $(@)) || (mkdir -p $(shell dirname $(@)))
	@#Has to be called from html/doc-VERSION to put scripts in the right place
	@cd html/`dirname doc-$(*)` && \
	  if [ "$(shell basename $(shell dirname $(@)))" != "html" ]; then \
	  mkdir -p scripts; fi && \
	  $(LIQI) \
	    --template ../../versioned.html --snippet-template ../../snippet.html \
		--subst version:`dirname $(*)` --basedir .. \
	    -i $(<) -o $(@)

$(PWD)/html/%.html: $(PWD)/content/%.txt $(LIQI) main.html
	@echo Converting main doc $(<) to $(@)...
	@test -d html/scripts || (mkdir -p html/scripts ; cp -rf orig/* html)
	@test -d $(shell dirname $(@)) || (mkdir -p $(shell dirname $(@)))
	@cd html && \
	  $(LIQI) \
	    --template ../main.html \
	    -i $(<) -o $(@)

clean:
	rm -rf html

RCP=rsync -rLtCPz --exclude="*.swp" --exclude="*.svn" \
	--delete --stats
RHOST=$(USER),savonet@web.sourceforge.net:/home/groups/s/sa/savonet/htdocs

upload: dist
	cd html ; $(RCP) . $(RHOST) || true

rss: $(PWD)/html/liquidsoap.rss

$(PWD)/html/liquidsoap.rss: news.txt
	echo '<?xml version="1.0" encoding="UTF-8" ?>\n<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">' > $@
	echo '<channel>' >> $@
	echo '<title>Liquidsoap: news</title>' >> $@
	echo '<description>savonet.sf.net</description>' >> $@
	echo '<atom:link href="http://savonet.sourceforge.net/liquidsoap.rss" rel="self" type="application/rss+xml" />' >> $@
	echo '<link>http://savonet.sf.net/</link>' >> $@
	echo -n '<lastBuildDate>' >> $@
	echo -n `date -R` >> $@
	echo '</lastBuildDate>' >> $@
	echo -n '<pubDate>' >> $@
	echo -n `date -R` >> $@
	echo '</pubDate>' >> $@
	echo '<item>' >> $@
#	echo '<link>http://savonet.sf.net/</link>' >> $@
	cat $^ \
	| grep -v '^#' \
	| sed 's|\&|\&amp;|g' | sed 's|<|\&lt;|g' | sed 's|>|\&gt;|g' \
	| sed 's|^\* \(.*\)$$|<title>Liquidsoap: \1</title>|' \
	| sed 's|^- date: \(.*\)$$|<pubDate>\1</pubDate>|' \
	| sed 's|^- link: \(.*\)$$|<link>\1</link>|' \
	| sed 's|^- descr: \(.*\)$$|<description>\n\1\n</description>|' \
	| sed 's|^$$|</item>\n<item>|' \
	>> $@
	echo '</item>' >> $@
	echo '</channel>' >> $@
	echo '</rss>' >> $@

html/_news.html: news.txt
	echo -n > $@
	echo '<div class="item">' >> $@
	cat $^ \
	| grep -v '^#' \
	| head -n 14 \
	| sed 's|^$$|</div>\n<div class="item">|' \
	| sed 's|^\* \(.*\)$$||' \
	| sed 's|^- date: .*\([0-9][0-9] [A-Z][a-z][a-z] [0-9][0-9][0-9][0-9]\).*$$|<div class="title">\1</div>|' \
	| sed 's|^- link: \(.*\)$$||' \
	| sed 's|^- descr: \(.*\)$$|<div class="content">\n\1\n</div>|' \
	>> $@
	echo '</div>' >> $@
