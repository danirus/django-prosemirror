###
# Builds this apps source
###

SHELL = /bin/bash

npmbin = $(shell npm bin)
cachedir ?= .build-cache
staticdir = prosemirror/static/prosemirror

all: build

# Build production release.
build: clean scss browserify

# Build development release.
dev: clean scss-dev browserify-dev

# Clean
clean:
	-rm -rf prosemirror/static/prosemirror/bundle.*
	-rm -rf prosemirror/static/prosemirror/*.min.*


scss-dev:
	test -d "$(cachedir)" || @mkdir "$(cachedir)"
	$(npmbin)/node-sass $(staticdir)/widget.scss $(cachedir)/widget.css \
	  --output-style nested --source-map $(cachedir)/widget.css.map
	cat $(cachedir)/widget.css | $(npmbin)/postcss --map --use autoprefixer > \
	  $(staticdir)/widget.min.css

scss:
	test -d "$(cachedir)" || @mkdir "$(cachedir)"
	$(npmbin)/node-sass $(staticdir)/widget.scss $(cachedir)/widget.css \
	  --output-style compressed;
	cat $(cachedir)/widget.css | $(npmbin)/postcss --use autoprefixer > \
	  $(staticdir)/widget.min.css

browserify-dev:
	$(npmbin)/browserify -d $(staticdir)/widget.js -o $(staticdir)/bundle.js

browserify:
	$(npmbin)/browserify -g uglifyify $(staticdir)/widget.js | \
	  $(npmbin)/uglifyjs -cm > $(staticdir)/widget.min.js

# Build wheel
package:
	@python setup.py sdist bdist_wheel
