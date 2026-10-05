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
#
# bin/new-app fills both dates with the scaffold date. Bump last_updated
# by hand on every later edit.
#
# FRONT MATTER - filled example
#   title: Third-Party Licenses
#   description: "Third-Party Licenses for Note Jar."
#   lang: en-US
#   lang_also: tr-TR
#   effective_date: 2026-09-06
#   last_updated: 2026-09-06
title: Third-Party Licenses
description: ""
lang: REPLACE-WITH-LANG
effective_date: YYYY-MM-DD
last_updated: YYYY-MM-DD

# Optional - add only if this page already lived at an older URL:
#   redirect_from:
#     - /apps/note-jar/third-party/
---

<!--
  WHAT GOES IN THE BODY
  Every open-source component the app ships, in Markdown - one "##"
  heading per component, with its copyright notice and licence text.
  Open with a sentence saying what the list is. Swap the placeholder
  line below for the real list.

  FILLED EXAMPLE

  Note Jar ships the open-source components listed below, with their
  copyright notices and licence terms.

  ## Feather (icon set)

  MIT License

  Copyright (c) 2013-2023 Cole Bemis

  Permission is hereby granted, free of charge, to any person obtaining
  a copy of this software [...] THE SOFTWARE IS PROVIDED "AS IS" [...]

  ## Inter (typeface)

  SIL Open Font License 1.1

  Copyright (c) 2016 The Inter Project Authors

  This Font Software is licensed under the SIL Open Font License,
  Version 1.1. [...]

  ## Contact

  Questions about the components used in Note Jar can be sent to the
  address shown on the Note Jar page.

  ## Changes

  If this page changes, the "Last updated" date above changes with it.
-->

Third-party licenses content goes here.
