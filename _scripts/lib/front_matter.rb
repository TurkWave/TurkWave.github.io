# frozen_string_literal: true
#
# Shared YAML front-matter handling for the repo's Ruby tooling.
#
# The three CI validators (_scripts/validate_*.rb) and bin/new-app all read - or,
# for bin/new-app, rewrite - the leading `--- ... ---` block of a Markdown source
# file. They each used to hand-roll it with small, drifting differences. This is
# now the single implementation.
#
# It is required with a bare `ruby` (the validators run without `bundle exec`),
# so it stays on the standard library only: `yaml` and `date`.
#
# --- Reconciled differences between the former copies -------------------------
#
#   * "no front matter" result
#       validate_urls.rb       -> nil
#       validate_redirects.rb  -> {}
#       lint_content.rb        -> [nil, text]
#     Adopted: `.parse` returns nil, `.split` returns [nil, body]. What the
#     absence MEANS (an error, or just "nothing to check") stays each caller's
#     decision - validate_urls / lint_content still treat it as an error,
#     validate_redirects still treats it as "no redirects".
#
#   * malformed YAML
#       lint_content.rb        -> rescued, reported as a lint failure
#       validate_urls.rb       -> uncaught, aborts with a backtrace
#       validate_redirects.rb  -> uncaught, aborts with a backtrace
#     Adopted: `.parse` raises FrontMatter::Error (wrapping any Psych::Exception,
#     which also covers a disallowed class - the old lint_content only caught
#     Psych::SyntaxError). Callers that report it rescue it; the others still
#     abort, now with a one-line message instead of a raw backtrace.
#
#   * YAML.safe_load permitted classes
#       validators             -> [Date, Time], aliases: true
#       bin/new-app self-check  -> none (would raise on a `date:` value)
#     Adopted: always [Date, Time], aliases: true.
#
#   * fence detection
#       validators             -> split on /^---\s*$/   (column-0 `---` only)
#       bin/new-app rewriter    -> line.strip == "---"   (also an indented `---`)
#     Adopted: a fence line is `---` at column 0 with only blanks after it. An
#     indented "   ---" is body, matching the validators and Jekyll itself.
#
#   * opening-delimiter check
#       all copies             -> text.start_with?("---")   (true for "---x" too)
#     Adopted: the opening `---` must be its own line.

require "date"
require "yaml"

module FrontMatter
  Error = Class.new(StandardError)

  # Opening `---` on its own line, then everything up to the next such line.
  # Group 1 is the raw front-matter text (nil when the block is empty).
  BLOCK_RE = /\A---[ \t]*\r?\n(.*?\n)?---[ \t]*(?:\r?\n|\z)/m

  PERMITTED_CLASSES = [Date, Time].freeze

  module_function

  # Split into [raw_front_matter_or_nil, body]. The front matter is returned
  # verbatim, never parsed. No front-matter block -> [nil, original_text].
  def split(text)
    m = BLOCK_RE.match(text)
    return [nil, text] unless m

    [m[1] || "", text[m.end(0)..] || ""]
  end

  # Parsed front matter as a Hash, or nil when there is no front-matter block.
  # Raises FrontMatter::Error on malformed YAML or a disallowed class.
  def parse(text)
    raw, = split(text)
    return nil if raw.nil?

    YAML.safe_load(raw, permitted_classes: PERMITTED_CLASSES, aliases: true) || {}
  rescue Psych::Exception => e
    raise Error, e.message
  end

  def parse_file(path)
    parse(File.read(path))
  end

  # Return `text` with `key: value` lines inside the LEADING front-matter block
  # rewritten from `replacements` (String keys). Lines below the closing fence -
  # including a `---` horizontal rule and any `key: value` under it - are left
  # untouched. Indentation and line endings are preserved; a replaced line is
  # newline-terminated even if the original was the unterminated last line.
  # A file with no front-matter block is returned unchanged.
  def fill(text, replacements)
    fence = 0
    text.each_line.map do |line|
      fence += 1 if fence_line?(line)
      m = line.match(/\A(\s*)([A-Za-z0-9_-]+):\s.*\n?\z/)
      if fence == 1 && m && replacements.key?(m[2])
        "#{m[1]}#{m[2]}: #{replacements[m[2]]}\n"
      else
        line
      end
    end.join
  end

  # A fence is `---` at column 0 followed only by blanks / end of line.
  def fence_line?(line)
    line.match?(/\A---[ \t]*\r?\n?\z/)
  end
end
