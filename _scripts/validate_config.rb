#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Check that _config.yml carries a usable support address. `contact_email` is
# rendered as a live mailto: on every app page (_layouts/app-index.html) and
# every document page (_layouts/legal-doc.html), so a missing or throwaway
# value ships a dead "Contact" link to every visitor.
#
# Fails when contact_email is:
#   * missing, empty, or not a plausible  local@domain.tld  address
#   * on a reserved / documentation domain - RFC 2606 (.example, .test,
#     .invalid, example.com/net/org) or RFC 6761 (localhost)
#
# Pure YAML read, no build needed. Run it before `jekyll build`.
# Exit 0 when clean, 1 with a one-line reason.

require "yaml"

REPO_ROOT   = File.expand_path("..", __dir__)
CONFIG_PATH = File.join(REPO_ROOT, "_config.yml")

EMAIL_RE = /\A[^@\s]+@((?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z]{2,})\z/i

# RFC 2606 / RFC 6761: never resolve to a real mailbox.
RESERVED_TLDS    = %w[example test invalid localhost].freeze
RESERVED_DOMAINS = %w[example.com example.net example.org].freeze

def fail!(reason)
  warn "contact_email check failed: #{reason}"
  exit 1
end

cfg =
  begin
    YAML.safe_load(File.read(CONFIG_PATH), permitted_classes: [], aliases: true) || {}
  rescue Errno::ENOENT
    fail!("_config.yml not found at #{CONFIG_PATH}")
  rescue Psych::Exception => e
    fail!("_config.yml is not valid YAML (#{e.message})")
  end

email = cfg["contact_email"]
fail!("contact_email is missing")               if email.nil?
fail!("contact_email is not a string")          unless email.is_a?(String)
fail!("contact_email is empty")                 if email.strip.empty?

m = EMAIL_RE.match(email.strip)
fail!("contact_email #{email.inspect} is not a valid local@domain.tld address") unless m

domain = m[1].downcase
labels = domain.split(".")
tld    = labels.last
sld    = labels.length >= 2 ? labels[-2..].join(".") : domain

fail!("contact_email domain #{domain.inspect} uses the reserved TLD .#{tld}") if RESERVED_TLDS.include?(tld)
fail!("contact_email domain #{domain.inspect} is a reserved documentation domain") if RESERVED_DOMAINS.include?(sld)
if (bad = (labels & RESERVED_TLDS).first)
  fail!("contact_email domain #{domain.inspect} contains the reserved label #{bad.inspect}")
end

puts "contact_email OK: #{email}"
exit 0
