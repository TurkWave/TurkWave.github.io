#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Enforce the frozen URL scheme  /apps/<app-slug>/<doc-slug>/  for every file in
# the docs collection. Pure front-matter scan - run it before `jekyll build`.
#
#   * every doc lives exactly one level deep:  _docs/<app-slug>/<file>.md
#   * <app-slug> and <doc-slug> are lowercase kebab-case
#   * index.md MUST declare  permalink: /apps/<app-slug>/   (Jekyll can't derive
#     a clean folder URL for it otherwise)
#   * any other doc MUST NOT declare a custom `permalink`
#
# Exit 0 when clean, 1 with a report listing file + expected vs actual URL.

require_relative "lib/front_matter"

REPO_ROOT = File.expand_path("..", __dir__)
DOCS_DIR  = File.join(REPO_ROOT, "_docs")
SLUG_RE   = /\A[a-z0-9]+(?:-[a-z0-9]+)*\z/

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

  if file == "index.md"
    expected = "/apps/#{app_slug}/"
    actual   = fm["permalink"]
    if actual != expected
      errors << "#{rel}\n  index.md must set  permalink: #{expected}\n  actual: #{actual.inspect}"
    end

    # index.md must render as the app index. With any other layout, default.html
    # builds the header back-link from the URL depth and lands on a dead /apps/.
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
      expected = "/apps/#{app_slug}/#{doc_slug}/"
      errors << "#{rel}\n  custom 'permalink' is not allowed on collection docs\n" \
                "  expected (from path): #{expected}\n  actual (front matter): #{fm["permalink"].inspect}"
    end

    # A content doc must use the collection default (legal-doc). The app-index /
    # home-apps layouts build a wrong back-link for a /apps/<app>/<doc>/ URL.
    if fm.key?("layout") && fm["layout"] != "legal-doc"
      errors << "#{rel}\n  collection docs must use  layout: legal-doc  (the default)\n" \
                "  actual: #{fm["layout"].inspect}"
    end
  end
end

if errors.empty?
  puts "URL scheme OK: #{count} document(s), all resolve to /apps/<app-slug>/<doc-slug>/"
  exit 0
end

warn "URL scheme violations (#{errors.length}):\n\n#{errors.join("\n\n")}"
exit 1
