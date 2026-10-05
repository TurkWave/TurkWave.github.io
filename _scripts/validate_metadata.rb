#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Check the search / AI metadata every page in _docs/ must carry - each app's
# index.md and each document. Pure front-matter scan, no build needed.
#
#   * description  a non-empty string. It becomes <meta name="description">;
#                  without it jekyll-seo-tag falls back to the page's first
#                  paragraph (a document) or the site-wide text (an app index).
#   * lang         one of LANGS. It becomes <html lang> and og:locale
#                  (_layouts/default.html, jekyll-seo-tag). It must be a single
#                  string: jekyll-seo-tag calls String#tr on it, so a YAML list
#                  would abort the build.
#   * lang_also    optional second language of a page that repeats its text;
#                  one of LANGS and different from lang.
#   * date,        documents only (an app index has no dates of its own): must
#     last_modified_at  repeat effective_date and last_updated. Jekyll stamps
#                  every collection document with the build time, which
#                  jekyll-seo-tag publishes as the page's dates and
#                  jekyll-sitemap as its lastmod; these two keys replace it with
#                  the real ones. They are copies, so they are checked.
#   * image        optional, any page: the share-preview picture (og:image). A
#                  /assets/ path to a PNG / JPG / WebP / GIF that exists in the
#                  repo. Never empty: jekyll-seo-tag would turn "" into the
#                  page's own URL. Never SVG: social previews do not render it.
#
# Exit 0 when clean, 1 with a per-file report of field + issue.

require_relative "lib/front_matter"

REPO_ROOT = File.expand_path("..", __dir__)
DOCS_DIR  = File.join(REPO_ROOT, "_docs")

# The two languages the site is written in. Each carries its region so that one
# value is valid both as <html lang> (BCP 47) and, with "-" turned into "_", as
# og:locale (language_TERRITORY). The templates ship `lang: REPLACE-WITH-LANG`,
# which is deliberately not in this list: a new app fails until the language is
# set by hand.
LANGS = %w[en-US tr-TR].freeze

# A share picture lives under /assets/ and is a raster format.
IMAGE_RE = %r{\A/assets/\S+\.(?:png|jpe?g|webp|gif)\z}i

errors = Hash.new { |h, k| h[k] = [] }

files = Dir.glob(File.join(DOCS_DIR, "**", "*.{md,markdown}")).sort

files.each do |path|
  rel = path.sub("#{REPO_ROOT}/", "")

  begin
    fm = FrontMatter.parse_file(path)
  rescue FrontMatter::Error => e
    errors[rel] << "front matter is not valid YAML (#{e.message})"
    next
  end
  if fm.nil?
    errors[rel] << "missing YAML front matter"
    next
  end

  desc = fm["description"]
  errors[rel] << "field 'description': missing or empty" if !desc.is_a?(String) || desc.strip.empty?

  lang = fm["lang"]
  errors[rel] << "field 'lang': #{lang.inspect} must be one of #{LANGS.join(", ")}" unless LANGS.include?(lang)

  unless File.basename(path) == "index.md"
    # Both sides are YAML dates (Date objects), so 2026-09-05 == 2026-09-05.
    { "date" => "effective_date", "last_modified_at" => "last_updated" }.each do |mirror, source|
      if fm[mirror].nil?
        errors[rel] << "field '#{mirror}': missing - repeat #{source} (#{fm[source]})"
      elsif fm[mirror] != fm[source]
        errors[rel] << "field '#{mirror}': #{fm[mirror]} must equal #{source} (#{fm[source]})"
      end
    end
  end

  if fm.key?("image")
    image = fm["image"]
    if !image.is_a?(String) || image.strip.empty?
      errors[rel] << "field 'image': empty - it would publish the page's own address as the picture; " \
                     "remove the line or give a /assets/... path"
    elsif image !~ IMAGE_RE || image.include?("..")
      errors[rel] << "field 'image': #{image.inspect} must be a /assets/... path ending in " \
                     ".png, .jpg, .jpeg, .webp or .gif (SVG is not shown by social previews)"
    elsif !File.file?(File.join(REPO_ROOT, image))
      errors[rel] << "field 'image': #{image} does not exist in the repo (paths are case-sensitive on the CI runner)"
    end
  end

  next unless fm.key?("lang_also")

  also = fm["lang_also"]
  if !LANGS.include?(also)
    errors[rel] << "field 'lang_also': #{also.inspect} must be one of #{LANGS.join(", ")} (or leave the line out)"
  elsif also == lang
    errors[rel] << "field 'lang_also': same as 'lang' (#{lang}) - give the OTHER language or leave the line out"
  end
end

if errors.empty?
  puts "Metadata OK: #{files.length} file(s) checked"
  exit 0
end

report = errors.map { |file, issues| "#{file}\n#{issues.map { |x| "  #{x}" }.join("\n")}" }
warn "Metadata check failures (#{errors.values.sum(&:length)}):\n\n#{report.join("\n\n")}"
exit 1
