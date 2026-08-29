#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Verify that every `redirect_from` entry in the docs collection actually
# produced a redirect page in _site/. Run AFTER `jekyll build`.
#
# jekyll-redirect-from turns  redirect_from: /old/path/  into
# _site/old/path/index.html containing a <meta http-equiv="refresh"> (plus a
# canonical link and a JS fallback) pointing at the document's real URL.
#
# Exit 0 when every entry has its page (or there are none), 1 otherwise,
# 2 when _site/ is missing.

require "date"
require "yaml"

REPO_ROOT = File.expand_path("..", __dir__)
DOCS_DIR  = File.join(REPO_ROOT, "_docs")
SITE_DIR  = File.join(REPO_ROOT, "_site")

unless Dir.exist?(SITE_DIR)
  warn "error: _site/ not found - run `bundle exec jekyll build` first"
  exit 2
end

def front_matter(path)
  text = File.read(path)
  return {} unless text.start_with?("---")

  parts = text.split(/^---\s*$/, 3)
  return {} if parts.length < 3

  YAML.safe_load(parts[1], permitted_classes: [Date, Time], aliases: true) || {}
end

def redirect_page?(html)
  html.match?(/http-equiv\s*=\s*["']?\s*refresh/i)
end

def rel(path)
  path.sub("#{REPO_ROOT}/", "")
end

entries = [] # [doc_rel, from]
Dir.glob(File.join(DOCS_DIR, "**", "*.{md,markdown}")).sort.each do |path|
  raw = front_matter(path)["redirect_from"]
  next if raw.nil?

  Array(raw).each { |from| entries << [rel(path), from.to_s] }
end

if entries.empty?
  puts "Redirects OK: no redirect_from entries to check"
  exit 0
end

errors = []
entries.each do |doc_rel, from|
  slug = from.strip.sub(%r{\A/}, "").sub(%r{/\z}, "")
  candidates = [File.join(SITE_DIR, slug, "index.html"), File.join(SITE_DIR, "#{slug}.html")]
  hit = candidates.find { |c| File.file?(c) && redirect_page?(File.read(c)) }

  if hit
    puts "ok  #{from}  ->  #{rel(hit)}"
  else
    errors << "#{doc_rel}\n  redirect_from: #{from}\n" \
              "  no redirect page generated (looked for: #{candidates.map { |c| rel(c) }.join(", ")})"
  end
end

if errors.empty?
  puts "\nRedirects OK: #{entries.length} #{entries.length == 1 ? "entry" : "entries"} verified"
  exit 0
end

warn "Redirect validation failures (#{errors.length}):\n\n#{errors.join("\n\n")}"
exit 1
