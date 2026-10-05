---
# FRONT MATTER - explanation
#
#   title           Heading shown on the page and in the "Legal & support"
#                   list on the app index. Keep the wording below.
#   description     One sentence for search engines and AI readers: what this
#                   document covers. bin/new-app writes a first version
#                   ("<Title> for <App Name>."); reword it if you like. Must
#                   not be empty.
#   lang            Language the text is written in - exactly one of:
#                     en-US   English
#                     tr-TR   Turkish
#                   Sets <html lang> and og:locale. bin/new-app cannot guess it,
#                   so the metadata check fails until you replace the
#                   placeholder below.
#   lang_also       Optional. Only for a page that repeats its text in a second
#                   language: that other language (same two values, not the
#                   same as lang). Leave the line out otherwise.
#   effective_date  When this version takes effect. Strict YYYY-MM-DD.
#   last_updated    Date of the most recent change. Strict YYYY-MM-DD,
#                   on or after effective_date, never in the future.
#   date            The same day as effective_date, repeated because search
#                   engines read this key as the page's published date.
#   last_modified_at  The same day as last_updated, repeated for the page's
#                   modified date and the sitemap's lastmod.
#
# bin/new-app fills all four dates with the scaffold date. On every later
# edit bump last_updated AND last_modified_at together: the metadata check
# fails if date or last_modified_at drifts from its twin. Note: this is the
# one document that also gets an "On this page" table of contents, built
# from its "##" headings.
#
# FRONT MATTER - filled example
#   title: Support
#   description: "Support for Note Jar."
#   lang: en-US
#   lang_also: tr-TR
#   effective_date: 2026-09-06
#   last_updated: 2026-09-06
#   date: 2026-09-06
#   last_modified_at: 2026-09-06
title: Support
description: ""
lang: REPLACE-WITH-LANG
effective_date: YYYY-MM-DD
last_updated: YYYY-MM-DD
date: YYYY-MM-DD
last_modified_at: YYYY-MM-DD

# Optional - add only if this page already lived at an older URL:
#   redirect_from:
#     - /apps/note-jar/support/
---

<!--
  WHAT GOES IN THE BODY
  How to get help with the app, in Markdown. Use "##" headings (they
  also become the on-page table of contents): getting help, contact,
  reporting a problem, feature requests, changes. Swap the placeholder
  line below for the real text.

  FILLED EXAMPLE

  This page explains how to get help with Note Jar.

  ## Getting help

  Note Jar runs entirely on your device and has no accounts or sign-in.
  Most questions are answered on the Note Jar page and in its FAQ.

  ## Contact

  Email the address shown on the Note Jar page. Replies are usually sent
  within a few business days.

  ## Reporting a problem

  Include your device model, operating-system version and the app
  version, along with the steps that reproduce the issue.

  ## Feature requests

  Suggestions are welcome at the same address. There is no guaranteed
  timeline for adding new features.

  ## Changes

  If this page changes, the "Last updated" date above changes with it.
-->

Support content goes here.
