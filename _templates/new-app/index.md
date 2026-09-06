---
layout: app-index
permalink: /REPLACE-WITH-APP-SLUG/
is_app_index: true
title: "Replace With App Name"

# ======================================================================
#  APP-INDEX PAGE
#
#  The whole page is built from this front matter. The Markdown body
#  below the closing "---" is NOT shown on the page - it only feeds the
#  SEO <meta description>. Put real content in the keys here.
#
#  HOW TO READ THIS FILE
#  Each block has two parts:
#    1. an EXPLANATION of what the key is and how it renders;
#    2. an "e.g." FILLED EXAMPLE showing a real value (all "e.g." lines
#       are comments - copy them onto the real key below to use them).
#  Then comes the real key, left empty. An empty value ("" or [])
#  hides that section; a filled value shows it.
#
#  A brand-new app with nothing filled in shows just the app name, the
#  auto-generated Legal links, Contact, and the Copyright line.
# ======================================================================


# --- Section switches: the one control block ---------------------------
#  EXPLANATION
#  Turn any block of this page off from here without touching its
#  content below. Value  on  (or deleting the line) shows a section;
#  off  / false  hides it. There is no on-page toggle - this is edited
#  in the source only. A section with no content stays hidden whatever
#  the switch says.
#
#  e.g. hide the reviews and pricing blocks, keep the rest:
#         reviews: off
#         pricing: off
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


# --- Header logo -----------------------------------------------------
#  EXPLANATION
#  App icon shown large at the top-left of the frame, with the app name
#  to its right. "logo" is a site-absolute path (usually under
#  /assets/img/<slug>/); "logo_alt" is its alt text and defaults to the
#  app name when left empty.
#
#  e.g.
#    logo: "/assets/img/note-jar/logo.svg"
#    logo_alt: "Note Jar app icon"
logo: ""
logo_alt: ""


# --- Subtitle -------------------------------------------------------
#  EXPLANATION
#  One free-text line under the app name in the header - smaller and
#  muted. Good for the publisher and the platforms.
#
#  e.g.
#    subtitle: "TurkWave - Mobile & PC"
subtitle: ""


# --- Taglines -----------------------------------------------------
#  EXPLANATION
#  "slogan" is one line shown just under the header. "sub_slogan" is a
#  click-to-open drawer (closed by default) shown just above the
#  "Get the app" buttons - use it for a secondary note.
#
#  e.g.
#    slogan: "Capture a thought before it's gone."
#    sub_slogan: "Works offline. No account, no ads."
slogan: ""
sub_slogan: ""


# --- Screenshots / video strip ----------------------------------
#  EXPLANATION
#  Horizontal media strip at a fixed height (drag / swipe / wheel /
#  arrow keys). Portrait, landscape and mixed sizes all fit - nothing
#  is cropped or resized while scrolling. Each entry is one of:
#    - image:  { src: "/assets/img/<slug>/1.png", alt: "..." }
#    - video:  { youtube: "<11-char id>", alt: "..." }
#  A video shows its YouTube cover image and loads the player only on
#  click; add  poster: "/assets/img/<slug>/x.jpg"  for a local cover.
#
#  e.g.
#    screenshots:
#      - { src: "/assets/img/note-jar/home.png", alt: "Home screen" }
#      - { src: "/assets/img/note-jar/editor.png", alt: "Note editor" }
#      - { youtube: "dQw4w9WgXcQ", alt: "One-minute tour" }
screenshots: []


# --- Store buttons ------------------------------------------------
#  EXPLANATION
#  The "Get the app" buttons. Known stores get a canonical label:
#  google-play, app-store, microsoft-store. Anything else is a free
#  pair  { label: "...", url: "..." }.
#
#  e.g.
#    store_links:
#      - { store: "google-play", url: "https://play.google.com/store/apps/details?id=com.turkwave.notejar" }
#      - { store: "app-store", url: "https://apps.apple.com/app/id1234567890" }
#      - { label: "Download for Windows", url: "https://turkwave.github.io/note-jar/win" }
store_links: []


# --- Where the app lives ---------------------------------------
#  EXPLANATION
#  "platform" shows under the app name on the site home page.
#  "app_url" is the app's own address: it becomes a "Website" button in
#  the store row, the "Open app" link on every document page, and is
#  shown next to "platform" on the home page.
#
#  e.g.
#    platform: "Android, iOS, Windows"
#    app_url: "https://turkwave.github.io/note-jar/"
platform: ""
app_url: ""


# --- Reviews / social proof ----------------------------------
#  EXPLANATION
#  Omit any single piece to hide it; omit all of them to hide the whole
#  Reviews section.
#    rating       { value:, max: (defaults to 5), count: }
#    downloads    free text
#    reviews      list of { author:, rating:, date:, text: }
#    reviews_url  link behind the "Read more reviews" line
#
#  e.g.
#    rating: { value: 4.7, max: 5, count: 312 }
#    downloads: "10,000+"
#    reviews:
#      - author: "A. Yilmaz"
#        rating: 5
#        date: "2026-07-14"
#        text: "Opens instantly and has never lost a note."
#    reviews_url: "https://play.google.com/store/apps/details?id=com.turkwave.notejar&showAllReviews=true"
reviews: []
reviews_url: ""


# --- Price line (header) ----------------------------------
#  EXPLANATION
#  Short price text shown in the header, right under the subtitle.
#  Printed verbatim (no forced "Pricing -" prefix), mid-sized and not
#  muted. Links down to the Pricing section when that section has
#  content; hidden together with it when sections.pricing = off.
#
#  e.g.
#    price_line: "Free - optional Pro unlock"
price_line: ""


# --- Pricing (section) ----------------------------------
#  EXPLANATION
#  A Markdown block - the detail behind the header's price line.
#
#  e.g.
#    pricing: |
#      Free to download and use.
#      A one-time **Pro** unlock (US$4.99) adds sync and themes.
pricing: ""


# --- FAQ ---------------------------------------------
#  EXPLANATION
#  An ordered list. Two shapes, mix them freely:
#    - { q: "...", a: "..." }   a question (the answer is Markdown)
#    - { title: "..." }         a heading grouping the questions below it
#  Write just the text: the layout prefixes each question with a bold
#  "Q -" and each answer with a bold "A -" - do not type those. Question
#  and answer text render in the same quiet style; only the markers are
#  bold. The first TWO QUESTIONS show directly; the rest - with their
#  headings - fold into a "Read more FAQs" toggle. Headings never count
#  toward that two, so a heading alone can't push a question into the
#  toggle.
#
#  e.g.
#    faq:
#      - title: "Getting started"
#      - q: "Do I need an account?"
#        a: "No. Note Jar works fully offline with no sign-in."
#      - q: "Where are my notes stored?"
#        a: "On your device only, unless you turn on Pro sync."
#      - title: "Billing"
#      - q: "Is the Pro unlock a subscription?"
#        a: "No - it is a one-time purchase."
faq: []


# --- Copyright line -------------------------------
#  EXPLANATION
#  Rights holder for the in-frame copyright line. Left empty it falls
#  back to  "(c) <current year> TurkWave. All rights reserved."
#
#  e.g.
#    copyright: "(c) 2026 TurkWave. Built in Istanbul."
copyright: ""


# --- Redirects (leave out for a new app) --------
#  EXPLANATION
#  Only when this app used to live at a different URL and you want the
#  old one to keep working (jekyll-redirect-from). A brand-new app has
#  no old URL, so this key is normally absent entirely.
#
#  e.g.
#    redirect_from:
#      - /apps/note-jar/
---

{% comment %}
This body is optional and is NOT rendered on the page. If you write one
sentence here, jekyll-seo-tag uses it as this page's
<meta name="description">; with nothing here the site-wide description
is used. Put real content in the front-matter keys above, not here.

Filled example:
  Note Jar is a fast offline note app for Android, iOS and Windows -
  capture a thought in one tap, no account required.
{% endcomment %}
