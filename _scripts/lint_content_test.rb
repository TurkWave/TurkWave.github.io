# frozen_string_literal: true
#
# Tests for _scripts/lint_content.rb. Stdlib only (minitest ships with Ruby).
# Run directly:  ruby _scripts/lint_content_test.rb
#
# The point of this suite: PLACEHOLDERS in lint_content.rb is hand-maintained
# and a comment says it "must be kept in sync" with _templates/. Nothing else
# enforces that. These tests run the real linter against the real shipped
# templates, so editing a template's placeholder wording (or dropping a needed
# PLACEHOLDERS entry) without keeping the two aligned turns this suite red.

require "minitest/autorun"
require "open3"
require "fileutils"
require "tmpdir"

class LintContentTest < Minitest::Test
  SCRIPT  = File.expand_path("lint_content.rb", __dir__)
  LIB     = File.expand_path("lib/front_matter.rb", __dir__)
  TPL_DIR = File.expand_path("../_templates", __dir__)

  # Every shipped template EXCEPT the app index (lint_content skips index.md).
  # Each is a scaffolding stub whose body is placeholder text the linter must
  # reject; a template that is ever intentionally written out in full would
  # need adding to a skip list here.
  BODY_TEMPLATES = Dir[File.join(TPL_DIR, "**", "*.md")]
                   .reject { |f| File.basename(f) == "index.md" }
                   .sort

  # Copy the real linter + lib into a throwaway repo with the given _docs/ tree
  # ({ "rel/path.md" => body }) and run it. Returns [combined_output, exit_code].
  def run_lint(docs)
    root = Dir.mktmpdir("lint-test-")
    FileUtils.mkdir_p(File.join(root, "_scripts", "lib"))
    FileUtils.cp(SCRIPT, File.join(root, "_scripts", "lint_content.rb"))
    FileUtils.cp(LIB, File.join(root, "_scripts", "lib", "front_matter.rb"))
    docs.each do |rel, body|
      abs = File.join(root, "_docs", rel)
      FileUtils.mkdir_p(File.dirname(abs))
      File.write(abs, body)
    end
    out, status = Open3.capture2e("ruby", File.join(root, "_scripts", "lint_content.rb"))
    [out, status.exitstatus]
  ensure
    FileUtils.remove_entry(root) if root
  end

  # A shipped template with only its dates filled must still be rejected, and
  # the reason must be the placeholder body text (not something incidental).
  def test_every_shipped_body_template_is_flagged_as_placeholder
    refute_empty BODY_TEMPLATES, "no non-index templates found under #{TPL_DIR}"
    BODY_TEMPLATES.each do |path|
      body = File.read(path).gsub("YYYY-MM-DD", "2020-01-01")
      rel  = "acme/#{File.basename(path)}"
      out, code = run_lint(rel => body)
      assert_equal 1, code, "#{path} (unedited) should fail lint_content, got:\n#{out}"
      assert_includes out, "placeholder text",
                      "#{path} must be caught by a PLACEHOLDERS entry; output:\n#{out}"
    end
  end

  # Real prose with valid front matter passes.
  def test_written_out_content_passes
    doc = <<~MD
      ---
      title: Privacy Policy
      effective_date: 2020-01-01
      last_updated: 2020-01-01
      ---

      Acme App runs entirely on your device and collects no personal information.
    MD
    out, code = run_lint("acme/privacy.md" => doc)
    assert_equal 0, code, out
    assert_includes out, "Content OK"
  end
end
