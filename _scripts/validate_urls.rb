#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Enforce the URL scheme  /<app-slug>/<doc-slug>/  (app index: /<app-slug>/)
# for every file in the docs collection. Pure front-matter scan - run it before
# `jekyll build`.
#
#   * every doc lives exactly one level deep:  _docs/<app-slug>/<file>.md
#   * <app-slug> and <doc-slug> are lowercase kebab-case
#   * <app-slug> is not one of RESERVED_SLUGS (it would collide with a real
#     top-level path such as /assets/ or the /apps/... redirect tree)
#   * index.md MUST declare  permalink: /<app-slug>/   (Jekyll would otherwise
#     emit /<app-slug>/index/ from the collection's  /:path/  permalink)
#   * any other doc MUST NOT declare a custom `permalink`
#
# Former /apps/<app-slug>/... URLs stay alive via jekyll-redirect-from
# (redirect_from: entries in _docs/*/*.md), checked by validate_redirects.rb.
#
# Exit 0 when clean, 1 with a report listing file + expected vs actual URL.

require_relative "lib/front_matter"

REPO_ROOT = File.expand_path("..", __dir__)
DOCS_DIR  = File.join(REPO_ROOT, "_docs")
SLUG_RE   = /\A[a-z0-9]+(?:-[a-z0-9]+)*\z/

# Top-level names already taken by the built site. An app folder with one of
# these slugs would publish to a URL that shadows (or is shadowed by) a real
# path: /assets/*, jekyll-sitemap's /sitemap.xml + /robots.txt, /404.html, the
# site root, and the /apps/... redirect stubs kept for the old URL scheme.
RESERVED_SLUGS = %w[apps assets sitemap robots 404 index].freeze

errors = []
count  = 0

Dir.glob(File.join(DOCS_DIR, "**", "*.{md,markdown}")).sort.each do |path|
  rel  = path.sub("#{REPO_ROOT}/", "")
  segs = path.sub("#{DOCS_DIR}/", "").split("/")

  unless segs.length == 2
    errors << "#{rel}\n  must live exactly one level deep: _docs/<app-slug>/<doc>.md"
    next
  end

  app_slug = segs[0]
  file     = segs[1]
  doc_slug = File.basename(file, ".*")
  count   += 1

  begin
    fm = FrontMatter.parse_file(path)
  rescue FrontMatter::Error => e
    errors << "#{rel}\n  front matter is not valid YAML (#{e.message})"
    next
  end
  if fm.nil?
    errors << "#{rel}\n  missing YAML front matter"
    next
  end

  errors << "#{rel}\n  app folder #{app_slug.inspect} is not lowercase kebab-case" unless app_slug =~ SLUG_RE
  if RESERVED_SLUGS.include?(app_slug)
    errors << "#{rel}\n  app folder #{app_slug.inspect} is a reserved top-level name " \
              "(#{RESERVED_SLUGS.join(", ")}) - it would collide with a real site path"
  end

  if file == "index.md"
    expected = "/#{app_slug}/"
    actual   = fm["permalink"]
    if actual != expected
      errors << "#{rel}\n  index.md must set  permalink: #{expected}\n  actual: #{actual.inspect}"
    end

    # index.md must render as the app index: the home page lists it and the
    # app-index layout builds the per-app document list from it.
    if fm["layout"] != "app-index"
      errors << "#{rel}\n  index.md must set  layout: app-index\n  actual: #{fm["layout"].inspect}"
    end

    # home-apps.html lists an app only if its index.md carries this flag.
    if fm["is_app_index"] != true
      errors << "#{rel}\n  index.md must set  is_app_index: true\n  actual: #{fm["is_app_index"].inspect}"
    end
  else
    errors << "#{rel}\n  doc slug #{doc_slug.inspect} is not lowercase kebab-case" unless doc_slug =~ SLUG_RE

    if fm.key?("permalink")
      expected = "/#{app_slug}/#{doc_slug}/"
      errors << "#{rel}\n  custom 'permalink' is not allowed on collection docs\n" \
                "  expected (from path): #{expected}\n  actual (front matter): #{fm["permalink"].inspect}"
    end

    # A content doc must use the collection default (legal-doc); the other
    # layouts don't render the document chrome (title, dates, app/contact line).
    if fm.key?("layout") && fm["layout"] != "legal-doc"
      errors << "#{rel}\n  collection docs must use  layout: legal-doc  (the default)\n" \
                "  actual: #{fm["layout"].inspect}"
    end
  end
end

if errors.empty?
  puts "URL scheme OK: #{count} document(s), all resolve to /<app-slug>/<doc-slug>/"
  exit 0
end

warn "URL scheme violations (#{errors.length}):\n\n#{errors.join("\n\n")}"
exit 1
