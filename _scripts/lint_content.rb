#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Lint published legal/support docs - everything in _docs/ except each app's
# index.md. Static scan, no build needed.
#
#   * front matter has: title, effective_date, last_updated
#   * effective_date and last_updated are strict YYYY-MM-DD calendar dates
#   * effective_date <= last_updated <= today
#   * no placeholder text (see PLACEHOLDERS) anywhere in the file
#
# Exit 0 when clean, 1 with a per-file report of field + issue.

require "date"
require "yaml"
require_relative "lib/front_matter"

REPO_ROOT = File.expand_path("..", __dir__)
DOCS_DIR  = File.join(REPO_ROOT, "_docs")
TODAY     = Date.today

# Case-insensitive substrings that mean a template was published unedited.
# Anchor each to a literal string from _templates/ so real legal prose is not
# caught - e.g. "we may replace with a successor service" is legitimate, so the
# bare phrase "replace with" cannot be on this list; the template's actual
# title "Replace With Document Title" can. "YYYY-MM-DD" is likewise omitted: an
# unfilled template date is already rejected by the strict date-format check,
# and a doc may legitimately mention the date format.
# Extend this list with the exact wording of any new template placeholder.
PLACEHOLDERS = [
  "sample content",
  "demonstration only",
  "replace with document title",  # _templates/new-doc.md title
  "replace with app name",        # _templates/new-app/index.md title
  "content goes here",            # "<X> content goes here." in every doc template body
  "lorem ipsum",
].freeze

DATE_RE = /\A\d{4}-\d{2}-\d{2}\z/

errors = Hash.new { |h, k| h[k] = [] }

docs = Dir.glob(File.join(DOCS_DIR, "**", "*.{md,markdown}")).sort
      .reject { |f| File.basename(f) == "index.md" }

docs.each do |path|
  rel  = path.sub("#{REPO_ROOT}/", "")
  text = File.read(path)
  fm_text, = FrontMatter.split(text)

  if fm_text.nil?
    errors[rel] << "missing YAML front matter"
  else
    begin
      fm = YAML.safe_load(fm_text, permitted_classes: [Date, Time], aliases: true) || {}
    rescue Psych::SyntaxError => e
      fm = {}
      errors[rel] << "front matter is not valid YAML (#{e.message})"
    end

    title = fm["title"]
    errors[rel] << "field 'title': missing or empty" if !title.is_a?(String) || title.strip.empty?

    # Read the raw date text: YAML coerces a valid date to a Date object, so the
    # exact YYYY-MM-DD spelling can only be checked against the source text.
    raw = {}
    fm_text.each_line do |l|
      m = l.match(/\A(effective_date|last_updated):\s*(.*?)\s*\z/)
      raw[m[1]] = m[2].gsub(/\A["']|["']\z/, "") if m
    end

    dates = {}
    %w[effective_date last_updated].each do |key|
      v = raw[key]
      if v.nil? || v.empty?
        errors[rel] << "field '#{key}': missing"
      elsif v !~ DATE_RE
        errors[rel] << "field '#{key}': #{v.inspect} is not strict YYYY-MM-DD"
      else
        begin
          dates[key] = Date.iso8601(v)
        rescue ArgumentError
          errors[rel] << "field '#{key}': #{v.inspect} is not a real calendar date"
        end
      end
    end

    eff = dates["effective_date"]
    upd = dates["last_updated"]
    errors[rel] << "effective_date (#{eff}) is after last_updated (#{upd})" if eff && upd && eff > upd
    dates.each do |key, d|
      errors[rel] << "field '#{key}': #{d} is in the future (today is #{TODAY})" if d > TODAY
    end
  end

  text.each_line.with_index(1) do |line, n|
    low = line.downcase
    PLACEHOLDERS.each do |p|
      errors[rel] << "line #{n}: placeholder text #{p.inspect}" if low.include?(p)
    end
  end
end

if errors.empty?
  puts "Content OK: #{docs.length} document(s) linted"
  exit 0
end

report = errors.map { |file, issues| "#{file}\n#{issues.map { |x| "  #{x}" }.join("\n")}" }
warn "Content lint failures (#{errors.values.sum(&:length)}):\n\n#{report.join("\n\n")}"
exit 1
