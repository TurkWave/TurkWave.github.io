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
# fails if date or last_modified_at drifts from its twin.
#
# FRONT MATTER - filled example
#   title: Privacy Policy
#   description: "Privacy Policy for Note Jar."
#   lang: en-US
#   lang_also: tr-TR
#   effective_date: 2026-09-06
#   last_updated: 2026-09-06
#   date: 2026-09-06
#   last_modified_at: 2026-09-06
title: Privacy Policy
description: ""
lang: REPLACE-WITH-LANG
effective_date: YYYY-MM-DD
last_updated: YYYY-MM-DD
date: YYYY-MM-DD
last_modified_at: YYYY-MM-DD

# Optional - add only if this page already lived at an older URL:
#   redirect_from:
#     - /apps/note-jar/privacy/
#     - /apps/note-jar/privacy-policy/
---

<!--
  WHAT GOES IN THE BODY
  How the app handles user data, in Markdown. Cover, under "##"
  headings: what is collected, analytics / tracking, third parties,
  children, contact, and changes. Swap the placeholder line below for
  the real text.

  FILLED EXAMPLE

  Note Jar runs entirely on your device. This policy describes how it
  handles your data.

  ## Information we collect

  Note Jar does not collect, store, or transmit personal information. It
  has no user accounts and no sign-in.

  ## Analytics and tracking

  The app bundles no analytics, advertising, or tracking SDKs, and makes
  no network requests of its own.

  ## Third parties

  Because no data is collected, none is shared with third parties.

  ## Children

  The app collects nothing from anyone, including children.

  ## Contact

  Questions about this policy can be sent to the address shown on the
  Note Jar page.

  ## Changes

  If this policy changes, the "Last updated" date above changes with it.
-->

Privacy policy content goes here.
