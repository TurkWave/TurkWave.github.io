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
#   make lint      config + URL + content validators (bare ruby, pre-build)
#   make validate  redirect validator (bare ruby, needs a build first)
#   make test      the Ruby test suites (bare ruby)
#   make clean     remove _site and .jekyll-cache
#   make preview   install, then serve

.DEFAULT_GOAL := help
.PHONY: help install serve build lint validate test clean preview

help:
	@echo "Targets: install | serve | build | lint | validate | test | clean | preview"
	@echo "  make install   - bundle install"
	@echo "  make serve     - local dev server with live reload (http://localhost:4000/)"
	@echo "  make build     - production build to _site/ (matches GitHub Actions)"
	@echo "  make lint      - run the config + URL + content validators (pre-build)"
	@echo "  make validate  - run the redirect validator (after a build)"
	@echo "  make test      - run the Ruby test suites"
	@echo "  make clean     - delete _site and .jekyll-cache"
	@echo "  make preview   - install deps, then serve"

install:
	bundle install

serve:
	bundle exec jekyll serve --livereload

build:
	JEKYLL_ENV=production bundle exec jekyll build

lint:
	ruby _scripts/validate_config.rb
	ruby _scripts/validate_urls.rb
	ruby _scripts/lint_content.rb

validate:
	ruby _scripts/validate_redirects.rb

test:
	ruby _scripts/lib/front_matter_test.rb
	ruby _scripts/validate_config_test.rb
	ruby _scripts/validate_urls_test.rb
	ruby _scripts/lint_content_test.rb
	ruby bin/new-app_test.rb

clean:
	rm -rf _site .jekyll-cache

preview: install serve
