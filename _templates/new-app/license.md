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
#   title: License
#   description: "License for Note Jar."
#   lang: en-US
#   lang_also: tr-TR
#   effective_date: 2026-09-06
#   last_updated: 2026-09-06
title: License
description: ""
lang: REPLACE-WITH-LANG
effective_date: YYYY-MM-DD
last_updated: YYYY-MM-DD

# Optional - add only if this page already lived at an older URL:
#   redirect_from:
#     - /apps/note-jar/license/
---

<!--
  WHAT GOES IN THE BODY
  The app's licence, in Markdown. Open with one line naming the licence,
  then reproduce its full text under a "## <Licence name>" heading. Swap
  the placeholder line below for the real text.

  FILLED EXAMPLE

  Note Jar is released under the MIT License. Its full text is
  reproduced below.

  ## MIT License

  Copyright (c) 2026 TurkWave

  Permission is hereby granted, free of charge, to any person obtaining
  a copy of this software and associated documentation files (the
  "Software"), to deal in the Software without restriction, including
  without limitation the rights to use, copy, modify, merge, publish,
  distribute, sublicense, and/or sell copies of the Software, and to
  permit persons to whom the Software is furnished to do so, subject to
  the following conditions:

  The above copyright notice and this permission notice shall be
  included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND [...]
-->

License content goes here.
