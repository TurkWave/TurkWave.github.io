# frozen_string_literal: true
#
# Tests for _scripts/validate_metadata.rb. Stdlib only (minitest ships with Ruby).
# Run directly:  ruby _scripts/validate_metadata_test.rb
#
# Like lint_content_test.rb, these run the real checker - here against throwaway
# _docs/ trees and against the real shipped templates, so a template that stops
# carrying the keys the checker reads (or ships a guessed language) turns this
# suite red.

require "minitest/autorun"
require "open3"
require "fileutils"
require "tmpdir"

class ValidateMetadataTest < Minitest::Test
  SCRIPT  = File.expand_path("validate_metadata.rb", __dir__)
  LIB     = File.expand_path("lib/front_matter.rb", __dir__)
  TPL_DIR = File.expand_path("../_templates", __dir__)

  # Every shipped template, the app index included: unlike lint_content, this
  # checker covers index.md too.
  TEMPLATES = Dir[File.join(TPL_DIR, "**", "*.md")].sort

  # The four date keys of a valid document: `date` and `last_modified_at` repeat
  # `effective_date` and `last_updated`.
  DATES = ["effective_date: 2026-01-01", "last_updated: 2026-01-02",
           "date: 2026-01-01", "last_modified_at: 2026-01-02"].freeze

  # Copy the real checker + lib into a throwaway repo with the given _docs/ tree
  # ({ "rel/path.md" => body }) and run it. Returns [combined_output, exit_code].
  def run_check(docs)
    root = Dir.mktmpdir("metadata-test-")
    FileUtils.mkdir_p(File.join(root, "_scripts", "lib"))
    FileUtils.cp(SCRIPT, File.join(root, "_scripts", "validate_metadata.rb"))
    FileUtils.cp(LIB, File.join(root, "_scripts", "lib", "front_matter.rb"))
    docs.each do |rel, body|
      abs = File.join(root, "_docs", rel)
      FileUtils.mkdir_p(File.dirname(abs))
      File.write(abs, body)
    end
    out, status = Open3.capture2e("ruby", File.join(root, "_scripts", "validate_metadata.rb"))
    [out, status.exitstatus]
  ensure
    FileUtils.remove_entry(root) if root
  end

  # A Markdown source whose front matter is the given lines.
  def page(*lines)
    "---\n#{lines.join("\n")}\n---\n\nBody.\n"
  end

  def test_valid_pages_pass
    out, code = run_check(
      "acme/index.md"   => page("title: Acme", 'description: "Acme does a thing."', "lang: en-US"),
      "acme/privacy.md" => page("title: Privacy Policy", 'description: "Privacy Policy for Acme."', "lang: tr-TR", *DATES)
    )
    assert_equal 0, code, out
    assert_includes out, "Metadata OK: 2 file(s) checked"
  end

  def test_a_page_in_two_languages_passes
    out, code = run_check(
      "acme/privacy.md" => page("title: P", 'description: "d"', "lang: tr-TR", "lang_also: en-US", *DATES)
    )
    assert_equal 0, code, out
  end

  def test_missing_or_blank_description_fails
    ["", 'description: ""', 'description: "   "', "description: 5"].each do |line|
      lines = ["title: P", "lang: en-US", *DATES]
      lines << line unless line.empty?
      out, code = run_check("acme/privacy.md" => page(*lines))
      assert_equal 1, code, "#{line.inspect} should fail, got:\n#{out}"
      assert_includes out, "field 'description'"
    end
  end

  def test_lang_must_be_one_of_the_two_supported_tags
    ["", "lang: en", "lang: tr", "lang: REPLACE-WITH-LANG", "lang: [tr-TR, en-US]"].each do |line|
      lines = ["title: P", 'description: "d"', *DATES]
      lines << line unless line.empty?
      out, code = run_check("acme/privacy.md" => page(*lines))
      assert_equal 1, code, "#{line.inspect} should fail, got:\n#{out}"
      assert_includes out, "field 'lang'"
    end
  end

  def test_lang_also_must_be_valid_and_different_from_lang
    base = ["title: P", 'description: "d"', "lang: tr-TR", *DATES]
    ["lang_also: tr-TR", "lang_also: de-DE", 'lang_also: ""'].each do |line|
      out, code = run_check("acme/privacy.md" => page(*base, line))
      assert_equal 1, code, "#{line.inspect} should fail, got:\n#{out}"
      assert_includes out, "field 'lang_also'"
    end
  end

  def test_document_dates_must_repeat_effective_date_and_last_updated
    base = ["title: P", 'description: "d"', "lang: en-US",
            "effective_date: 2026-01-01", "last_updated: 2026-01-02"]
    cases = {
      "date missing"             => [base, "field 'date'"],
      "date differs"             => [base + ["date: 2026-01-03", "last_modified_at: 2026-01-02"], "field 'date'"],
      "last_modified_at missing" => [base + ["date: 2026-01-01"], "field 'last_modified_at'"],
      "last_modified_at differs" => [base + ["date: 2026-01-01", "last_modified_at: 2026-01-01"],
                                     "field 'last_modified_at'"]
    }
    cases.each do |name, (lines, needle)|
      out, code = run_check("acme/privacy.md" => page(*lines))
      assert_equal 1, code, "#{name} should fail, got:\n#{out}"
      assert_includes out, needle, name
    end
  end

  # The app index has no effective_date / last_updated, so it has nothing to repeat.
  def test_app_index_needs_no_dates
    out, code = run_check("acme/index.md" => page("title: Acme", 'description: "d"', "lang: en-US"))
    assert_equal 0, code, out
  end

  def test_missing_front_matter_and_bad_yaml_are_reported_not_raised
    out, code = run_check("acme/privacy.md" => "Just text, no front matter.\n")
    assert_equal 1, code, out
    assert_includes out, "missing YAML front matter"

    out, code = run_check("acme/terms.md" => page("title: [unclosed"))
    assert_equal 1, code, out
    assert_includes out, "not valid YAML"
  end

  # The templates are the starting point of every new app. Each must carry the
  # keys the checker reads, with `description` empty (bin/new-app fills it) and
  # `lang` an unset placeholder - so a new app cannot go live with a guessed
  # language.
  def test_every_shipped_template_fails_until_lang_is_set
    refute_empty TEMPLATES, "no templates found under #{TPL_DIR}"
    TEMPLATES.each do |path|
      out, code = run_check("acme/#{File.basename(path)}" => File.read(path))
      assert_equal 1, code, "#{path} (unedited) should fail, got:\n#{out}"
      assert_includes out, "field 'lang'", "#{path} must leave lang unset; output:\n#{out}"
      assert_includes out, "field 'description'",
                      "#{path} must ship an empty description for bin/new-app to fill; output:\n#{out}"
    end
  end

  def test_every_shipped_template_passes_once_description_and_lang_are_filled
    TEMPLATES.each do |path|
      body = File.read(path)
                 .sub('description: ""', 'description: "A real sentence."')
                 .sub("lang: REPLACE-WITH-LANG", "lang: en-US")
      out, code = run_check("acme/#{File.basename(path)}" => body)
      assert_equal 0, code, "#{path} should pass once filled, got:\n#{out}"
    end
  end
end
