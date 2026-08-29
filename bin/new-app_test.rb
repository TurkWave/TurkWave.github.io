# frozen_string_literal: true
#
# Tests for bin/new-app. Stdlib only (minitest ships with Ruby). Run directly:
#   ruby bin/new-app_test.rb
#
# Each test runs the real script against a throwaway REPO_ROOT built from the
# repo's own _templates/new-app/ and _scripts/lib/, so it exercises the actual
# file writing, slug validation, date handling and stdout.

require "minitest/autorun"
require "open3"
require "fileutils"
require "tmpdir"
require "date"

class NewAppTest < Minitest::Test
  REPO   = File.expand_path("..", __dir__)
  SCRIPT = File.join(REPO, "bin", "new-app")

  def setup
    @root = Dir.mktmpdir("new-app-test-")
    FileUtils.mkdir_p(File.join(@root, "bin"))
    FileUtils.mkdir_p(File.join(@root, "_scripts", "lib"))
    FileUtils.cp(SCRIPT, File.join(@root, "bin", "new-app"))
    FileUtils.cp(File.join(REPO, "_scripts", "lib", "front_matter.rb"),
                 File.join(@root, "_scripts", "lib", "front_matter.rb"))
    FileUtils.cp_r(File.join(REPO, "_templates"), File.join(@root, "_templates"))
    File.write(File.join(@root, "_config.yml"),
               %(url: "https://example.test"\nbaseurl: ""\n))
  end

  def teardown
    FileUtils.remove_entry(@root)
  end

  # Run the sandboxed script; return [combined_output, Process::Status].
  def run_new_app(*args)
    Open3.capture2e("ruby", File.join(@root, "bin", "new-app"), *args,
                    chdir: @root, stdin_data: "")
  end

  def docs(slug)
    Dir[File.join(@root, "_docs", slug, "*.md")].sort
  end

  def test_valid_slug_scaffolds_four_files_with_fields_filled
    out, status = run_new_app("widget-viewer", "--no-edit", "--date", "2026-05-06")
    assert status.success?, out
    assert_equal %w[index.md license.md privacy.md terms.md],
                 docs("widget-viewer").map { |f| File.basename(f) }

    index = File.read(File.join(@root, "_docs", "widget-viewer", "index.md"))
    assert_includes index, "permalink: /apps/widget-viewer/\n"
    assert_includes index, %(title: "Widget Viewer"\n)

    %w[privacy terms license].each do |name|
      body = File.read(File.join(@root, "_docs", "widget-viewer", "#{name}.md"))
      assert_includes body, "effective_date: 2026-05-06\n"
      assert_includes body, "last_updated: 2026-05-06\n"
    end

    assert_includes out, "Name:   Widget Viewer (derived from slug)"
  end

  def test_default_date_is_today
    _out, status = run_new_app("today-app", "--no-edit")
    assert status.success?
    privacy = File.read(File.join(@root, "_docs", "today-app", "privacy.md"))
    assert_includes privacy, "effective_date: #{Date.today.iso8601}\n"
  end

  def test_multiword_slug_name_has_spaces
    out, status = run_new_app("my-cool-app", "--no-edit")
    assert status.success?
    assert_includes out, "Name:   My Cool App (derived from slug)"
    assert_includes File.read(File.join(@root, "_docs", "my-cool-app", "index.md")),
                    %(title: "My Cool App"\n)
  end

  def test_invalid_slugs_exit_nonzero_and_write_nothing
    ["Upper", "-lead", "trail-", "dou--ble", "sp ace", "under_score"].each do |slug|
      out, status = run_new_app(slug, "--no-edit")
      refute status.success?, "expected failure for #{slug.inspect}: #{out}"
      refute File.exist?(File.join(@root, "_docs", slug)), "#{slug.inspect} left a folder"
    end
  end

  def test_existing_folder_is_refused
    _out, first = run_new_app("dup-app", "--no-edit")
    assert first.success?
    out, second = run_new_app("dup-app", "--no-edit")
    refute second.success?
    assert_includes out, "already exists"
  end

  def test_future_date_is_refused
    out, status = run_new_app("future-app", "--no-edit", "--date", "9999-01-01")
    refute status.success?
    assert_includes out, "future"
    refute File.exist?(File.join(@root, "_docs", "future-app"))
  end

  def test_malformed_date_is_refused
    out, status = run_new_app("bad-date-app", "--no-edit", "--date", "2026-13-40")
    refute status.success?
    assert_includes out, "real YYYY-MM-DD date"
  end

  def test_no_args_exits_2_with_usage
    out, status = run_new_app
    assert_equal 2, status.exitstatus
    assert_includes out, "Usage: bin/new-app"
  end

  def test_fill_only_touches_the_leading_front_matter_block
    # A template doc whose BODY contains a `---` rule and a line that looks like
    # a front-matter key. Only the leading block must be rewritten.
    tricky = File.join(@root, "_templates", "new-app", "data.md")
    File.write(tricky, <<~MD)
      ---
      title: Data
      effective_date: YYYY-MM-DD
      last_updated: YYYY-MM-DD
      ---

      Body paragraph.

      ---

      effective_date: SENTINEL-must-survive
    MD

    _out, status = run_new_app("fence-app", "--no-edit", "--date", "2026-02-03")
    assert status.success?
    data = File.read(File.join(@root, "_docs", "fence-app", "data.md"))
    assert_includes data, "effective_date: 2026-02-03\n"
    assert_includes data, "last_updated: 2026-02-03\n"
    assert_includes data, "effective_date: SENTINEL-must-survive\n"
    assert_equal 1, data.scan(/^effective_date: SENTINEL-must-survive$/).length
    assert_equal 1, data.scan(/^effective_date: 2026-02-03$/).length
  end
end
