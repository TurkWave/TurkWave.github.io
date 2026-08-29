# frozen_string_literal: true
#
# Tests for the shared front-matter helper. Stdlib only (minitest ships with
# Ruby). Run directly:  ruby _scripts/lib/front_matter_test.rb

require "minitest/autorun"
require "date"
require_relative "front_matter"

class FrontMatterTest < Minitest::Test
  DOC = <<~MD
    ---
    title: Privacy Policy
    effective_date: 2026-08-29
    last_updated: 2026-08-29
    ---

    Body line one.

    ---

    effective_date: a body line that looks like a key
  MD

  def test_split_returns_raw_front_matter_and_body
    fm, body = FrontMatter.split(DOC)
    assert_equal "title: Privacy Policy\neffective_date: 2026-08-29\nlast_updated: 2026-08-29\n", fm
    # body is everything after the closing fence line, verbatim (Jekyll keeps
    # the leading blank line too).
    assert_match(/\A\s*Body line one\./, body)
    assert_includes body, "effective_date: a body line that looks like a key"
  end

  def test_parse_returns_hash_with_dates_permitted
    fm = FrontMatter.parse(DOC)
    assert_equal "Privacy Policy", fm["title"]
    assert_equal Date.new(2026, 8, 29), fm["effective_date"]
    assert_kind_of Date, fm["last_updated"]
  end

  def test_no_front_matter
    assert_equal [nil, "plain text\n"], FrontMatter.split("plain text\n")
    assert_nil FrontMatter.parse("plain text\n")
  end

  def test_opening_delimiter_must_be_its_own_line
    assert_nil FrontMatter.parse("---not a fence\ntitle: x\n---\n")
    assert_nil FrontMatter.parse("----\ntitle: x\n----\n")
  end

  def test_empty_front_matter_block
    fm, body = FrontMatter.split("---\n---\nhello\n")
    assert_equal "", fm
    assert_equal "hello\n", body
    assert_equal({}, FrontMatter.parse("---\n---\nhello\n"))
  end

  def test_parse_raises_frontmatter_error_on_bad_yaml
    err = assert_raises(FrontMatter::Error) { FrontMatter.parse("---\nkey: [unclosed\n---\n") }
    refute_includes err.message, "\n"
  end

  def test_parse_raises_on_disallowed_class
    assert_raises(FrontMatter::Error) { FrontMatter.parse("---\nwhen: !ruby/object {}\n---\n") }
  end

  def test_fill_rewrites_only_the_leading_block
    out = FrontMatter.fill(DOC, "effective_date" => "2026-01-02", "last_updated" => "2026-01-02")
    assert_includes out, "effective_date: 2026-01-02\n"
    assert_includes out, "last_updated: 2026-01-02\n"
    assert_includes out, "effective_date: a body line that looks like a key\n"
    assert_equal 1, out.scan(/^effective_date: a body line that looks like a key/).length
    assert_equal 1, out.scan(/^effective_date: 2026-01-02$/).length
  end

  def test_fill_preserves_indentation_and_unlisted_keys
    src = "---\n  title: Old\n  keep: yes\n---\nbody\n"
    out = FrontMatter.fill(src, "title" => "New")
    assert_equal "---\n  title: New\n  keep: yes\n---\nbody\n", out
  end

  def test_fill_noop_without_front_matter
    assert_equal "no fm\n", FrontMatter.fill("no fm\n", "title" => "x")
  end

  def test_fill_terminates_replaced_last_line
    assert_equal "---\ntitle: y\n---", FrontMatter.fill("---\ntitle: x\n---", "title" => "y")
  end
end
