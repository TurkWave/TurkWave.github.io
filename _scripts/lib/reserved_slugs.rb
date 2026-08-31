# frozen_string_literal: true
#
# The single list of app-slugs that may not be used, shared by
# _scripts/validate_urls.rb (rejects them in _docs/) and bin/new-app (refuses to
# scaffold them). Their tests read it from here too, so the four copies that
# used to be kept in sync by hand are now one.
#
# Each would publish to a URL that shadows (or is shadowed by) a real top-level
# path: /assets/*, jekyll-sitemap's /sitemap.xml + /robots.txt, /404.html, the
# site root, and the /apps/... redirect stubs kept for the old URL scheme.
#
# Stdlib-only: required with a bare `ruby` (the validators run without
# `bundle exec`).

module ReservedSlugs
  LIST = %w[apps assets sitemap robots 404 index].freeze
end
