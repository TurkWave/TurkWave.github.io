---
layout: app-index
permalink: /REPLACE-WITH-APP-SLUG/
is_app_index: true
title: "Replace With App Name"

# --- Section switches: the one control block ------------------------------
# Turn any block of this page off from here without touching its content
# below. Write  off  (or  false) to hide a section;  on  (or delete the line)
# shows it. There is no on-page UI - this is edited in the source only. A
# section with no content stays hidden regardless.
sections:
  slogan: on
  screenshots: on
  sub_slogan: on
  stores: on
  reviews: on
  pricing: on
  faq: on
  legal: on
  contact: on
  copyright: on

# --- App-index page content ------------------------------------------------
# Every key below is OPTIONAL. A section renders only when its key is set; an
# empty value hides that section (same rule as "platform" / "app_url"). A brand-
# new app with nothing filled in shows just the app name, the auto-generated
# Legal links, Contact, and the Copyright line.

# App icon shown large at the top-left of the frame, with the app name to its
# right.
logo: ""
logo_alt: ""

# Free-text line under the app name in the header - smaller and muted, same
# kind of value as "title". Good for the publisher and the platforms, e.g.
# "TurkWave  -  Mobile & PC".
subtitle: ""

# One-line taglines. "slogan" sits just under the header. "sub_slogan" is a
# click-to-open drawer (closed by default) shown just above "Get the app".
slogan: ""
sub_slogan: ""

# Horizontal media strip at a fixed height - portrait, landscape and mixed
# sizes all fit, nothing is cropped or resized while scrolling. Each entry is
# either an image or a YouTube video:
#   - { src: "/assets/img/<slug>/1.png", alt: "Home screen" }
#   - { youtube: "dQw4w9WgXcQ", alt: "Feature tour" }
# A video shows its YouTube cover image and loads the player only on click;
# add  poster: "/assets/img/<slug>/x.jpg"  to use a local cover instead.
screenshots: []

# "Get the app" buttons. Known stores (canonical label applied): google-play,
# app-store, microsoft-store. Anything else: { label: "...", url: "..." }.
store_links: []

# Where the app lives. "platform" shows under the app name on the home page;
# "app_url" is the app's own link - a "Website" button in the row above, the
# "Open app" link on the document pages, and shown next to "platform" on the
# home page.
platform: ""
app_url: ""

# Social proof. Omit any piece to hide it; omit all to hide the Reviews section.
# rating: { value: 4.6, max: 5, count: 128 }
# downloads: ""
reviews: []
reviews_url: ""

# Short price line shown in the header, right under the subtitle. Free text,
# printed verbatim (no forced "Pricing -" prefix), mid-sized and not muted.
# Links down to the Pricing section when it has content; hidden together with
# that section when sections.pricing = off. Empty -> no header price line.
price_line: ""

# Pricing: a Markdown block - the detail behind the header's price line, e.g.
#   pricing: |
#     Free to download.
pricing: ""

# FAQ: a list of entries rendered in order. Two shapes, mix them freely:
#   - { q: "...", a: "..." }   a question (the answer is Markdown)
#   - { title: "..." }         a heading to group the questions beneath it
# Write just the text: the layout prefixes each question with a bold "Q -" and
# each answer with a bold "A -" - do not type those yourself. Question text and
# answer text render in the same quiet style; only the "Q -" / "A -" are bold.
# The first two QUESTIONS show directly; the rest - with their headings - fold
# into a "Read more FAQs" toggle. Headings never count toward that two, so a
# heading can't push a real question into the toggle on its own. Example:
#   faq:
#     - title: "Billing"
#     - q: "Is there a free tier?"
#       a: "Yes - every core feature works without paying."
#     - q: "How do I cancel?"
#       a: "Open the app's settings and pick *Cancel subscription*."
#     - title: "Privacy"
#     - q: "Do you sell my data?"
#       a: "No. See the Privacy Policy linked under Legal & support."
faq: []

# Rights holder for the in-frame copyright line. Empty -> "(c) <year> TurkWave.
# All rights reserved."
copyright: ""

# --- Redirects (leave out for a new app) ---------------------------------
# Only when this app used to live at a different URL and you want the old one
# to keep working (jekyll-redirect-from). A brand-new app has no old URL.
#   redirect_from:
#     - /apps/REPLACE-WITH-APP-SLUG/
---

{% comment %}
This body is optional and is NOT rendered on the page. If you write a sentence
here, jekyll-seo-tag uses it as the page's <meta name="description">; with
nothing here the site-wide description is used. Put real content in the
front-matter keys above, not here.
{% endcomment %}
