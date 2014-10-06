NODE_PREFIX=$(shell npm prefix)
NODE_MODULES=$(NODE_PREFIX)/node_modules

CSS_MIN=$(NODE_MODULES)/.bin/cleancss
JS_MIN=$(NODE_MODULES)/.bin/uglifyjs
#JS_HINT=$(NODE_MODULES)/.bin/jshint

CSS_FILES=\
	src/css/clizia.css\
	src/css/stacked.css\
	src/css/standard.css\
	src/css/horizon.css

JS_FILES=\
	src/js/clizia.js\
	src/js/utils.js\
	src/js/graph.js\
	src/js/graph/horizon.js\
	src/js/graph/rickshaw.js\
	src/js/graph/rickshaw/stacked.js\
	src/js/graph/rickshaw/standard.js\
	src/js/graph/rickshaw/slider.js

VENDOR_JS_FILES=\
	vendor/jquery-1.10.2.min.js\
	vendor/d3.v3.js\
	vendor/d3.layout.min.js\
	vendor/rickshaw.min.js\
	vendor/bootstrap.min.js\
	vendor/nanobar.js\
	vendor/cubism.v1.js


VENDOR_CSS_FILES=\
	vendor/rickshaw.min.css\
	vendor/font-awesome.relative.min.css

.PHONY: clean build

build: vendor_bundle.js vendor_bundle.css clizia.min.css clizia.min.js

clean:
	rm -rf clizia.css clizia.js clizia.min.*

#$(JS_HINT):
#	npm install jshint

$(CSS_MIN):
	npm install clean-css

$(JS_MIN):
	npm install uglify-js

$(JSDOM):
	npm install jsdom

$(NODEUNIT):
	npm install nodeunit

clizia.css: $(CSS_FILES)
	cat $(CSS_FILES) > clizia.css

vendor_bundle.css: $(VENDOR_CSS_FILES)
	cat $(VENDOR_CSS_FILES) > vendor_bundle.css

vendor_bundle.js: $(VENDOR_JS_FILES)
	cat $(VENDOR_JS_FILES) > vendor_bundle.js


#clizia.js: $(JS_FILES)	$(JS_HINT)
clizia.js: $(JS_FILES)
#	$(JS_HINT) src/js/*
	cat $(JS_FILES) > clizia.js

clizia.min.css: $(CSS_MIN) clizia.css
	$(CSS_MIN) clizia.css > clizia.min.css

clizia.min.js: $(JS_MIN) clizia.js
	$(JS_MIN) --reserved-names "\$$super" clizia.js > clizia.min.js

