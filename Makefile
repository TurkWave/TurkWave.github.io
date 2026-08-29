# Local preview + build helpers.
#
# Recipes assume a POSIX shell: standard on macOS/Linux, provided by Git Bash on
# Windows. `make` itself is standard on Unix and installable on Windows via
#   scoop install make      (or)      choco install make
#
# Targets:
#   make install   bundle install
#   make serve     bundle exec jekyll serve --livereload   (http://localhost:4000/)
#   make build     production build to _site/ (same env as CI)
#   make clean     remove _site and .jekyll-cache
#   make preview   install, then serve

.DEFAULT_GOAL := help
.PHONY: help install serve build clean preview

help:
	@echo "Targets: install | serve | build | clean | preview"
	@echo "  make install   - bundle install"
	@echo "  make serve     - local dev server with live reload (http://localhost:4000/)"
	@echo "  make build     - production build to _site/ (matches GitHub Actions)"
	@echo "  make clean     - delete _site and .jekyll-cache"
	@echo "  make preview   - install deps, then serve"

install:
	bundle install

serve:
	bundle exec jekyll serve --livereload

build:
	JEKYLL_ENV=production bundle exec jekyll build

clean:
	rm -rf _site .jekyll-cache

preview: install serve
