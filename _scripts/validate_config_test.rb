# frozen_string_literal: true
#
# Tests for _scripts/validate_config.rb. Stdlib only. Run directly:
#   ruby _scripts/validate_config_test.rb
#
# Drives the real script against a throwaway REPO_ROOT holding just a _config.yml.

require "minitest/autorun"
require "open3"
require "fileutils"
require "tmpdir"

class ValidateConfigTest < Minitest::Test
  SCRIPT = File.expand_path("validate_config.rb", __dir__)

  def check(config_body)
    root = Dir.mktmpdir("cfg-test-")
    FileUtils.mkdir_p(File.join(root, "_scripts"))
    FileUtils.cp(SCRIPT, File.join(root, "_scripts", "validate_config.rb"))
    File.write(File.join(root, "_config.yml"), config_body)
    out, status = Open3.capture2e("ruby", File.join(root, "_scripts", "validate_config.rb"))
    [out, status.exitstatus]
  ensure
    FileUtils.remove_entry(root) if root
  end

  def assert_ok(body)
    out, code = check(body)
    assert_equal 0, code, out
    assert_includes out, "contact_email OK"
  end

  def assert_rejected(body, reason_substring)
    out, code = check(body)
    assert_equal 1, code, "expected exit 1 for:\n#{body}\ngot:\n#{out}"
    assert_includes out, reason_substring
  end

  def test_normal_address_passes
    assert_ok(%(contact_email: "support@turkwave.com"\n))
    assert_ok(%(contact_email: "help@turkwave.co.uk"\n))
    assert_ok(%(contact_email: "team@my-latest-app.io"\n))
  end

  def test_the_repos_current_placeholder_is_rejected
    assert_rejected(%(contact_email: "support@turkwave.example"\n), "reserved TLD .example")
  end

  def test_reserved_tlds
    assert_rejected(%(contact_email: "x@foo.test"\n), "reserved TLD .test")
    assert_rejected(%(contact_email: "x@foo.invalid"\n), "reserved TLD .invalid")
  end

  def test_reserved_documentation_domains
    assert_rejected(%(contact_email: "x@example.com"\n), "reserved documentation domain")
    assert_rejected(%(contact_email: "x@mail.example.org"\n), "reserved documentation domain")
  end

  def test_reserved_label_anywhere_in_domain
    assert_rejected(%(contact_email: "x@test.turkwave.io"\n), "reserved label")
  end

  def test_missing_empty_and_malformed
    assert_rejected(%(title: "no email"\n), "missing")
    assert_rejected(%(contact_email: ""\n), "empty")
    assert_rejected(%(contact_email: "localhost"\n), "not a valid")
    assert_rejected(%(contact_email: "x@localhost"\n), "not a valid")
    assert_rejected(%(contact_email: "not-an-email"\n), "not a valid")
  end

  def test_non_string_value
    assert_rejected(%(contact_email:\n  - a@b.com\n), "not a string")
  end
end
