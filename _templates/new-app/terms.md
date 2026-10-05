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
#   title: Terms of Use
#   description: "Terms of Use for Note Jar."
#   lang: en-US
#   lang_also: tr-TR
#   effective_date: 2026-09-06
#   last_updated: 2026-09-06
#   date: 2026-09-06
#   last_modified_at: 2026-09-06
title: Terms of Use
description: ""
lang: REPLACE-WITH-LANG
effective_date: YYYY-MM-DD
last_updated: YYYY-MM-DD
date: YYYY-MM-DD
last_modified_at: YYYY-MM-DD

# Optional - add only if this page already lived at an older URL:
#   redirect_from:
#     - /apps/note-jar/terms/
---

<!--
  WHAT GOES IN THE BODY
  The terms the user agrees to by using the app, in Markdown. Cover,
  under "##" headings: acceptance, licence / permitted use, limitation
  of liability, changes. Swap the placeholder line below for the real
  text.

  FILLED EXAMPLE

  These terms apply to Note Jar.

  ## Acceptance

  By installing or using Note Jar you agree to these terms. If you do
  not agree, do not use the app.

  ## License

  Note Jar is provided free of charge, "as is" and without warranty of
  any kind, express or implied. You may use it for personal,
  non-commercial purposes.

  ## Limitation of liability

  To the maximum extent permitted by law, TurkWave is not liable for any
  damages arising from the use of, or inability to use, the app.

  ## Changes

  These terms may be revised from time to time. Continued use of the app
  after a change takes effect means you accept the revised terms.
-->

Terms of use content goes here.
