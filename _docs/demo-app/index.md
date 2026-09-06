---
layout: app-index
permalink: /demo-app/
is_app_index: true
title: "Demo App"

# --- Section switches: the one control block ------------------------------
# Turn any block of this page off from here without touching its content
# below. Write  off  (or  false) to hide a section;  on  (or delete the line)
# shows it. There is no on-page UI - this is edited in the source only. A
# section with no content stays hidden regardless, exactly as before.
#   slogan | screenshots | sub_slogan | stores | reviews | pricing | faq
#   legal  | contact | copyright
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

# --- App-index page content -------------------------------------------------
# Every block below is OPTIONAL. A section renders only when its key is set;
# an empty value hides that section and its divider (same rule as the existing
# "platform" / "app_url" conditionals). All values here are DEMO DATA for the
# sample entry and use example.com (IANA's reserved example domain) on purpose.

# Logo shown large at the top-left of the frame, with the app name to its right.
logo: "/assets/img/demo-app/logo.svg"
logo_alt: "Demo App logo (placeholder)"

# Free-text line under the app name (smaller, muted) - publisher + platforms.
subtitle: "TurkWave · Mobile & PC · demo publisher line"

# One-line taglines. "slogan" sits just under the header. "sub_slogan" is a
# click-to-open drawer (closed by default) shown just above "Get the app".
slogan: "A second demo entry, used to show two cards side by side on the home page."
sub_slogan: "The rating, download count and reviews below are placeholder data."

# Horizontal media strip (drag / swipe / wheel / arrow keys) at a fixed
# height - portrait, landscape and mixed sizes all fit, nothing is cropped or
# resized while scrolling. Entries are images or YouTube videos. A video shows
# its YouTube cover image and only loads the player when clicked; add
# `poster: "/assets/img/<slug>/x.jpg"` to use a local cover instead.
screenshots:
  - { src: "/assets/img/demo-app/screenshot-1.svg", alt: "Home screen (placeholder)" }
  - { youtube: "aqz-KE-bpKQ", alt: "Product tour (placeholder video: Blender 'Big Buck Bunny', CC BY)" }
  - { src: "/assets/img/demo-app/screenshot-2.svg", alt: "Detail screen (placeholder)" }
  - { src: "/assets/img/demo-app/screenshot-3.svg", alt: "Settings screen (placeholder)" }

# "Get the app" buttons. Known stores (canonical label applied): google-play,
# app-store, microsoft-store. Anything else: { label: "...", url: "..." }.
store_links:
  - { store: "google-play", url: "https://play.google.com/store/apps/details?id=com.example.demo2" }
  - { store: "app-store", url: "https://apps.apple.com/app/id000000001" }
  - { store: "microsoft-store", url: "https://apps.microsoft.com/detail/0000000000001" }
  - { label: "Source on GitHub", url: "https://github.com/TurkWave" }

# Where the app lives. "platform" shows under the app name on the home page;
# "app_url" is the app's own link - a "Website" button in the row above, the
# "Open app" link on the document pages, and shown next to "platform" on the
# home page. "platform" is left empty on purpose so the demo's home-page
# listing stays unchanged.
platform: ""
app_url: "https://example.com/demo-app"

# Social proof. Omit any piece to hide it; omit all three to hide the section.
rating: { value: 4.7, max: 5, count: 58 }
downloads: "2,000+ (placeholder)"
reviews:
  - author: "Demo reviewer"
    rating: 5
    date: "2026-08-20"
    text: "Placeholder review text for the layout. Not a real review."
  - author: "Another demo user"
    rating: 4
    date: "2026-08-27"
    text: "A second placeholder review so the fade-out and the read-more link are visible on the page."
reviews_url: "https://example.com/demo-app/reviews"

# Short price line shown in the header, right under the subtitle. Free text,
# printed verbatim (no forced "Pricing —" prefix). Mid-sized and full-strength,
# not muted. It links down to the Pricing section when that section has content,
# and rides the same switch: sections.pricing = off hides this line too.
price_line: "Pricing — Free"

# Pricing: a Markdown block - the detail behind the header's price line. The
# section itself is unchanged; price_line above is just a header shortcut to it.
pricing: |
  Free to download. This is placeholder pricing copy — an optional one-time
  "Pro" unlock is shown here only as an example.

# FAQ: an ordered list mixing two shapes - { title: "..." } headings and
# { q: "...", a: "..." } pairs (answers are Markdown). Write just the text; the
# layout adds a bold "Q -" before each question and a bold "A -" before each
# answer, both in the same quiet style as the text that follows. The first two
# QUESTIONS show directly; the rest, with their headings, fold into a "Read
# more FAQs" toggle. Headings never count toward that two.
faq:
  - q: "Is this a real app?"
    a: "No. Demo App is a second demo entry that shows how two app cards sit side by side on the home page."
  - q: "Where does this content come from?"
    a: "Each app's `index.md` front matter. An empty key hides its section."
  - q: "How is a long FAQ list handled?"
    a: "Entries past the first two collapse behind a \"Read more FAQs\" toggle that expands and re-collapses the rest, right where you left off."

# Copyright line at the foot of the frame. Empty -> "(c) <year> TurkWave.
# All rights reserved." Set it to name a different rights holder for an app.
copyright: ""

# The one-line body below is not rendered on the page; jekyll-seo-tag uses it
# as this page's <meta name="description">.
---

Demo App is a second demo entry on this site; every value on this page is placeholder content.
