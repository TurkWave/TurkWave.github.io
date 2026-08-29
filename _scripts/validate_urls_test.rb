# frozen_string_literal: true
#
# Tests for _scripts/validate_urls.rb. Stdlib only (minitest ships with Ruby).
# Run directly:  ruby _scripts/validate_urls_test.rb
#
# Each test builds a throwaway REPO_ROOT holding a copy of the validator + the
# shared front_matter lib and a synthetic _docs/ tree, then runs the real
# script against it and checks stdout + exit code.

require "minitest/autorun"
require "open3"
require "fileutils"
require "tmpdir"

class ValidateUrlsTest < Minitest::Test
  SCRIPT = File.expand_path("validate_urls.rb", __dir__)
  LIB    = File.expand_path("lib/front_matter.rb", __dir__)

  INDEX_OK = <<~MD
    ---
    layout: app-index
    permalink: /good-app/
    is_app_index: true
    title: "Good App"
    ---
  MD

  DOC_OK = <<~MD
    ---
    title: Privacy Policy
    effective_date: 2026-01-01
    last_updated: 2026-01-01
    ---

    Body.
  MD

  # Build a throwaway repo with the given _docs/ tree ({ "rel/path.md" => body })
  # and run the real validator against it. Returns [combined_output, exit_code].
  def run_validator(docs)
    root = Dir.mktmpdir("urls-test-")
    FileUtils.mkdir_p(File.join(root, "_scripts", "lib"))
    FileUtils.cp(SCRIPT, File.join(root, "_scripts", "validate_urls.rb"))
    FileUtils.cp(LIB, File.join(root, "_scripts", "lib", "front_matter.rb"))
    docs.each do |rel, body|
      abs = File.join(root, "_docs", rel)
      FileUtils.mkdir_p(File.dirname(abs))
      File.write(abs, body)
    end
    out, status = Open3.capture2e("ruby", File.join(root, "_scripts", "validate_urls.rb"))
    [out, status.exitstatus]
  ensure
    FileUtils.remove_entry(root) if root
  end

  def assert_ok(docs)
    out, code = run_validator(docs)
    assert_equal 0, code, out
    assert_includes out, "URL scheme OK"
  end

  def assert_rejected(docs, reason_substring)
    out, code = run_validator(docs)
    assert_equal 1, code, "expected exit 1, got:\n#{out}"
    assert_includes out, reason_substring
  end

  def test_clean_app_passes
    assert_ok("good-app/index.md" => INDEX_OK, "good-app/privacy.md" => DOC_OK)
  end

  def test_index_must_use_the_new_scheme_permalink
    assert_rejected(
      { "good-app/index.md" => INDEX_OK.sub("permalink: /good-app/", "permalink: /apps/good-app/") },
      "index.md must set  permalink: /good-app/",
    )
  end

  def test_index_missing_permalink_is_rejected
    assert_rejected(
      { "good-app/index.md" => INDEX_OK.sub("permalink: /good-app/\n", "") },
      "index.md must set  permalink: /good-app/",
    )
  end

  def test_custom_permalink_on_a_doc_is_rejected
    doc = DOC_OK.sub("last_updated: 2026-01-01\n", "last_updated: 2026-01-01\npermalink: /good-app/privacy/\n")
    assert_rejected(
      { "good-app/index.md" => INDEX_OK, "good-app/privacy.md" => doc },
      "custom 'permalink' is not allowed",
    )
  end

  def test_reserved_app_slug_is_rejected
    %w[apps assets sitemap robots 404 index].each do |slug|
      assert_rejected(
        { "#{slug}/index.md" => INDEX_OK.sub("permalink: /good-app/", "permalink: /#{slug}/") },
        "reserved top-level name",
      )
    end
  end

  def test_doc_more_than_one_level_deep_is_rejected
    assert_rejected(
      { "good-app/index.md" => INDEX_OK, "good-app/sub/privacy.md" => DOC_OK },
      "one level deep",
    )
  end

  def test_non_default_layout_on_a_doc_is_rejected
    assert_rejected(
      { "good-app/index.md" => INDEX_OK,
        "good-app/privacy.md" => DOC_OK.sub("title: Privacy Policy", "layout: app-index\ntitle: Privacy Policy") },
      "layout: legal-doc",
    )
  end

  def test_uppercase_app_slug_is_rejected
    assert_rejected(
      { "BadApp/index.md" => INDEX_OK.sub("permalink: /good-app/", "permalink: /BadApp/") },
      "not lowercase kebab-case",
    )
  end
end
