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

.PHONY: clean build

build: clizia.min.css clizia.min.js

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

#clizia.js: $(JS_FILES)	$(JS_HINT)
clizia.js: $(JS_FILES)
#	$(JS_HINT) src/js/*
	cat $(JS_FILES) > clizia.js

clizia.min.css: $(CSS_MIN) clizia.css
	$(CSS_MIN) clizia.css > clizia.min.css

clizia.min.js: $(JS_MIN) clizia.js
	$(JS_MIN) --reserved-names "\$$super" clizia.js > clizia.min.js

